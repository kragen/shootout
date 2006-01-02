/* The Computer Language Shootout
 * http://shootout.alioth.debian.org/
 * Contributed by Branimir Maksimovic
 * should be linked with -lpthread
 */

#include <pthread.h>
#include <iostream>
#include <ostream>
using namespace std;

#define arrLen(arr) (sizeof arr / sizeof arr[0])

enum Colour { blue, red, yellow, faded };

class MeetingPlace
{
private:
 Colour first, second;
 bool firstCall;
 bool mustWait;
 int n;
 pthread_cond_t monitor;
 pthread_mutex_t mlock;

public:
MeetingPlace(int maxMeetings)
: firstCall(true),mustWait(false),n(maxMeetings)
{
  pthread_cond_init(&monitor,0);
  pthread_mutex_init(&mlock,0);
}

Colour OtherCreaturesColour(Colour me)
{
    pthread_mutex_lock(&mlock);
    Colour other;

    while (mustWait)
    {
      pthread_cond_wait(&monitor,&mlock);
    }

    if (firstCall)
    {
      if (n-- > 0)
      {
        first = me;
        firstCall = false;

        while (!firstCall)
        {
          pthread_cond_wait(&monitor,&mlock);
        }
        mustWait = false;
        other = second;
      }
      else
      {
        other = faded;
      }
    }
    else
    {
      second = me;
      other = first;
      firstCall = true;
      mustWait = true;
    }

    pthread_cond_broadcast(&monitor);
    pthread_mutex_unlock(&mlock);
    return other;
}
~MeetingPlace()
{
  pthread_cond_destroy(&monitor);
  pthread_mutex_destroy(&mlock);
}
private:
MeetingPlace(const MeetingPlace&);
MeetingPlace& operator=(const MeetingPlace&);
};

class Creature
{
private:
  MeetingPlace* m;
  int creaturesMet_;
  Colour me;

public:
  Creature(MeetingPlace* m_, Colour c)
  :m(m_),creaturesMet_(0),me(c)
  {
  }

  void Be()
  {
    while(me != faded){ MeetOtherCreature(); }
  }

  void MeetOtherCreature()
  {
    Colour other = m->OtherCreaturesColour(me);
    if (other == faded)
    {
      me = other;
    }
    else
    {
      creaturesMet_++;
      me = Complement(other);
    }
  }
  Colour Complement(Colour other)
  {
    if (me == other) return me;
    switch(me)
    {
      case blue:
            return other == red ? yellow : red;
      case red:
            return other == blue ? yellow : blue;
      case yellow:
            return other == blue ? red : blue;
      default: return me;
    }
   }
   int creaturesMet()const { return creaturesMet_; }
};

static Colour colours []= { blue, red, yellow, blue };
static Creature* creatures[arrLen(colours)];
static pthread_t threads[arrLen(colours)];

extern "C" void* thread_run(void* c)
{
  ((Creature*)c)->Be();
  return 0;
}

int main(int argc,char*argv[])
{
  if(argc<2)return 0;
  int n = atoi(argv[1]);
  MeetingPlace m(n);

  for (unsigned i=0; i<arrLen(colours); i++)
  {
    creatures[i] = new Creature(&m,colours[i]);
    pthread_create(&threads[i],0,thread_run,creatures[i]);
  }

  for(unsigned i =0; i<arrLen(colours); i++)
    pthread_join(threads[i],0);

  int meetings = 0;
  for(unsigned i=0;i<arrLen(colours);i++)
  {
    meetings += creatures[i]->creaturesMet();
    delete creatures[i];
  }

  cout<<meetings<<'\n';
  return 0;
}
