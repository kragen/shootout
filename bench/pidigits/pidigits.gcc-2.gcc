/* The Computer Language Shootout
  http://shootout.alioth.debian.org/

  contributed by Sean Bartell
  based on the Scheme PLT #4 version
  with a few things from the C GNU gcc version
*/

#include <stdio.h>
#include <stdlib.h>
#include <gmp.h>

static mpz_t numer, accum, denom, tmp;

static unsigned int extract_digit(unsigned int n)
{
  mpz_mul_ui(tmp, numer, n);
  mpz_add(tmp, tmp, accum);
  mpz_tdiv_q(tmp, tmp, denom);
  return mpz_get_ui(tmp);
}

static void next_term(unsigned int k)
{
  unsigned int y2 = k*2 + 1;
  mpz_addmul_ui(accum, numer, 2);
  mpz_mul_ui(accum, accum, y2);
  mpz_mul_ui(numer, numer, k);
  mpz_mul_ui(denom, denom, y2);
}

static void eliminate_digit(unsigned int d)
{
  mpz_submul_ui(accum, denom, d);
  mpz_mul_ui(accum, accum, 10);
  mpz_mul_ui(numer, numer, 10);
}

static void pidigits(unsigned int n)
{
  unsigned int d, i = 0, k = 0, m;
  mpz_init(tmp);
  mpz_init_set_ui(numer, 1);
  mpz_init_set_ui(accum, 0);
  mpz_init_set_ui(denom, 1);

  for(;;)
  {
    do {
      k++;
      next_term(k);
    } while(mpz_cmp(numer, accum)>0
        || (d = extract_digit(3)) != extract_digit(4));

    putchar(d + '0');

    i++;
    m = i%10;
    if(m == 0)
      printf("\t:%d\n", i);
    if(i >= n)
      break;
    eliminate_digit(d);
  }

  if(m) {
    m = 10 - m;
    while(m--)
      putchar(' ');
    printf("\t:%d\n", n);
  }
}

int main(int argc, char **argv)
{
  pidigits(argc > 1 ? atoi(argv[1]) : 27);
  return 0;
}
