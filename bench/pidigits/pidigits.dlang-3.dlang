/* The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Mike Pall

   converted to D by Dave Fladebo
   compile: dmd -O -inline -release -I../../Include/dlang/gmp4d -L-lgmp pidigits3.d

   GMP for D library provided by Ben Hinkle (http://home.comcast.net/~benhinkle/gmp-d/)
*/

import std.stdio, std.string, gmp;

void main(char[][] args)
{
    ctx_t c;
    c.n = args.length > 1 ? atoi(args[1]) : 27;
    pidigits(&c);
}

/* Generate successive digits of PI. */
void pidigits(ctx_t* c)
{
    int k = 1;
    c.d = 0;
    c.i = 0;
    mpz_init_set_ui(c.q, 1);
    mpz_init_set_ui(c.r, 0);
    mpz_init_set_ui(c.s, 0);
    mpz_init_set_ui(c.t, 1);
    mpz_init(c.u);
    mpz_init(c.v);
    mpz_init(c.w);
    for(;;)
    {
        int y = extract(c, 3);
        if(y == extract(c, 4))
        {
            if(prdigit(c, y)) return;
            compose_r(c, 10, -10*y, 0, 1);
        }
        else
        {
            compose_l(c, k, 4*k+2, 0, 2*k+1);
            k++;
        }
    }
}

struct ctx_t
{
    mpz_t q, r, s, t;	/* Transformation matrix components. */
    mpz_t u, v, w;	/* Temporary numbers. */
    int d, i, n;	/* Counters. */
    char digits[10];	/* Accumulated digits for one line. */
}

/* Print one digit. Returns 1 for the last digit. */
int prdigit(ctx_t* c, int y)
{
    c.digits[c.d++] = '0'+y;
    if(++c.i % 10 == 0 || c.i == c.n)
    {
        writefln("%-10s\t:%d", c.digits, c.i);
        c.d = 0;
    }
    return c.i == c.n;
}

/* Extract one digit. */
int extract(ctx_t* c, uint j)
{
    mpz_mul_ui(c.u, c.q, j);
    mpz_add(c.u, c.u, c.r);
    mpz_mul_ui(c.v, c.s, j);
    mpz_add(c.v, c.v, c.t);
    mpz_tdiv_q(c.w, c.u, c.v);
    return mpz_get_ui(c.w);
}

/* Compose matrix with numbers on the right. */
void compose_r(ctx_t* c, int bq, int br, int bs, int bt)
{
    mpz_mul_si(c.u, c.r, bs);
    mpz_mul_si(c.r, c.r, bq);
    mpz_mul_si(c.v, c.t, br);
    mpz_add(c.r, c.r, c.v);
    mpz_mul_si(c.t, c.t, bt);
    mpz_add(c.t, c.t, c.u);
    mpz_mul_si(c.s, c.s, bt);
    mpz_mul_si(c.u, c.q, bs);
    mpz_add(c.s, c.s, c.u);
    mpz_mul_si(c.q, c.q, bq);
}

/* Compose matrix with numbers on the left. */
void compose_l(ctx_t* c, int bq, int br, int bs, int bt)
{
    mpz_mul_si(c.r, c.r, bt);
    mpz_mul_si(c.u, c.q, br);
    mpz_add(c.r, c.r, c.u);
    mpz_mul_si(c.u, c.t, bs);
    mpz_mul_si(c.t, c.t, bt);
    mpz_mul_si(c.v, c.s, br);
    mpz_add(c.t, c.t, c.v);
    mpz_mul_si(c.s, c.s, bq);
    mpz_add(c.s, c.s, c.u);
    mpz_mul_si(c.q, c.q, bq);
}

// Reset the GMP memory functions back to the GMP default.
//  This is needed because gmp4d/gmppool.d is linked in by the
//  Shootout build command (as needed by version 1 of pidigits.d).
//  gmp4d/gmppool.d overrides the GMP default if it is linked
//  w/ the application.
static this()
{
    mp_set_memory_functions(&malloc, &_realloc, &_free);
}

extern(C)
{
    void* malloc(size_t);
    void* realloc(void*,size_t);
    void  free(void*);
    void* _realloc(void* ptr, size_t old, size_t sz)
    {
        return realloc(ptr,sz);
    }
    void  _free(void* ptr, size_t sz)
    {
        free(ptr);
    }
}
