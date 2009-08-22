/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
   
   contributed by Ryan Flynn
   
   process-based concurrency via fork()
   IPC via pipe()/read()/write()
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/select.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

enum Color {
  blue, red, yellow, COLOR_CNT
};

static const char* ColorName[COLOR_CNT] = {
  "blue", "red", "yellow"
};

static const enum Color Compliment[COLOR_CNT][COLOR_CNT] = {
               /* blue    red     yellow */
  /* blue   */ {  blue,   yellow, red    },
  /* red    */ {  yellow, red,    blue   },
  /* yellow */ {  red,    blue,   yellow }
};

static char * formatNumber(unsigned n, char *outbuf)
{
  static const char *Digits[] = {
    "zero ", "one ", "two ",   "three ", "four ",
    "five ", "six ", "seven ", "eight ", "nine "
  };
  char tmp[64], *t = tmp;
  sprintf(tmp, "%u", n);
  *outbuf = '\0';
  while (*t)
    strcat(outbuf, Digits[*t++ - '0']);
  outbuf[strlen(outbuf)-1] = '\0';
  return outbuf;
}

static void printColors(void)
{
  for (enum Color x = blue; x <= yellow; x++)
    for (enum Color y = blue; y <= yellow; y++)
      printf("%s + %s -> %s\n",
        ColorName[x], ColorName[y], ColorName[Compliment[x][y]]);
  fputc('\n', stdout);
}

struct Creature
{
  struct Meet {
    unsigned   id:12,
               two_met:1,
               same_id:1;
    enum Color color;
    unsigned   cnt,
               sameCnt;
  } meet;
  int          from[2], /* from[0]: creature read
                         * from[1]: master write */
               to[2];   /*   to[0]: master read
                         *   to[1]: creature write */
};

/* format meeting times of each creature to string */
static inline char * Creature_getResult(const struct Creature *cr, char *str)
{
  formatNumber(cr->meet.sameCnt,
    str + sprintf(str, "%u ", cr->meet.cnt));
  return str;
}

static inline const char * Creature_init(struct Creature *cr,
                                         const enum Color color)
{
  static int CreatureID = 0;
  cr->meet.cnt = cr->meet.sameCnt = 0;
  cr->meet.id = ++CreatureID;
  cr->meet.color = color;
  cr->meet.two_met = false;
  pipe(cr->from);
  pipe(cr->to);
  return ColorName[color];
}

/* merge transient meeting results with creature state */
static inline void Meet_merge(const struct Meet *src, struct Meet *dst)
{
  dst->color = src->color;
  dst->cnt++;
  dst->two_met |= src->two_met;
  dst->same_id |= src->same_id;
  if (src->same_id)
    dst->sameCnt++;
}

static inline void runCreature(struct Creature *c)
{
  struct Meet m;
  do {
    write(c->to[1], &c->meet, sizeof m); /* request meeting  */
    read(c->from[0], &m, sizeof m);      /* meeting result   */
    Meet_merge(&m, &c->meet);            /* update state     */
  } while (m.two_met);
  write(c->to[1], &c->meet, sizeof m);   /* send final state */
  exit(0);
}

static inline void meet(struct Creature *c0, struct Creature *c1)
{
  struct Meet *m0 = &c0->meet,
              *m1 = &c1->meet;
  m0->cnt = m1->cnt = 1;
  m0->color = m1->color = Compliment[m0->color][m1->color];
  m0->two_met = m1->two_met = true;
  m0->same_id = m1->same_id = m0->id == m1->id;
  write(c0->from[1], &c0->meet, sizeof c0->meet);
  write(c1->from[1], &c1->meet, sizeof c1->meet);
}

static inline void doneMeetings(const int n, struct Creature *c)
{
  /* game's over, collect final state and reap creatures */
  for (int i = 0; i < n; i++) {
    c[i].meet.two_met = false;
    write(c[i].from[1], &c[i].meet, sizeof c[i].meet);
  }
  for (int _, i = 0; i < n; i++) {
    read(c[i].to[0], &c[i].meet, sizeof c[i].meet);
    wait(&_);
  }
}

static void doMeetings(int meetings, const int n, struct Creature *c)
{
  const int maxfd = c[n-1].to[0];
  int i, metcnt = 0;
  while (meetings) {
    struct Creature *met[2];
    fd_set rd;
    FD_ZERO(&rd);
    /* monitor creatures' meeting requests */
    for (i = 0; i < n; i++)
      if (!metcnt || met[0] != c+i)
        FD_SET(c[i].to[0], &rd);
    if (select(maxfd+1, &rd, NULL, NULL, NULL) <= 0)
      continue;
    /* meet() any two willing creatures */
    for (i = 0; i < n; i++) {
      if (!FD_ISSET(c[i].to[0], &rd))
        continue;
      if (read(c[i].to[0], &c[i].meet, sizeof c[i].meet) > 0) {
        met[metcnt++] = c+i;
        if (metcnt == 2) {
          meet(met[0], met[1]);
          metcnt = 0;
          if (--meetings == 0)
            break;
        }
      }
    }
  }
  doneMeetings(n, c);
}

/* print per creature and total meet count */
static inline void printResults(const unsigned n, const struct Creature *c)
{
  char str[256];
  unsigned total = 0;
  for (unsigned i = 0; i < n; total += c[i].meet.cnt, i++)
    printf("%s\n", Creature_getResult(c+i, str));
  printf(" %s\n\n", formatNumber(total, str));
}

static void initGame(int meetings, const unsigned n, const enum Color *color)
{
  unsigned i;
  struct Creature *c = calloc(n, sizeof *c);
  /* initial creature color */
  for (i = 0; i < n; i++)
    printf("%s ", Creature_init(c+i, color[i]));
  fputc('\n', stdout);
  /* launch creatures */
  for (i = 0; i < n; i++)
    if (0 == fork())
      runCreature(c+i);
  doMeetings(meetings, n, c);
  printResults(n, c);
  free(c);
}

int main(int argc, char* argv[])
{
  const enum Color r[] = {
   blue, red,    yellow,
   red,  yellow, blue,
   red,  yellow, red,
   blue
  };
  int n = (argc == 2) ? atoi(argv[1]) : 600;
  printColors();
  initGame(n, 3u, r);
  initGame(n, sizeof r / sizeof r[0], r);
  return 0;
}

