#include "GmpUtil.h"
#include "gmp.h"

/*
 * Class:     GmpUtil
 * Method:    mpz_init
 * Signature: ()J
 */
JNIEXPORT jlong JNICALL Java_GmpUtil_mpz_1init
  (JNIEnv *x, jclass y)
{
  mpz_t *p = malloc( sizeof(__mpz_struct) );
  __gmpz_init( *p );

  return (jlong)p;
}

/*
 * Class:     GmpUtil
 * Method:    mpz_clear
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_GmpUtil_mpz_1clear
  (JNIEnv *x, jclass y, jlong o)
{
  mpz_t* p = (mpz_t*)o;
  __gmpz_clear( *p );
  free( p );
}

/*
 * Class:     GmpUtil
 * Method:    mpz_set_si
 * Signature: (JI)V
 */
JNIEXPORT void JNICALL Java_GmpUtil_mpz_1set_1si
  (JNIEnv *x, jclass y, jlong dest, jint val)
{
  __gmpz_set_si( *((mpz_t*)dest), (long) val);
}

/*
 * Class:     GmpUtil
 * Method:    mpz_get_si
 * Signature: (J)I
 */
JNIEXPORT jint JNICALL Java_GmpUtil_mpz_1get_1si
  (JNIEnv *x, jclass y, jlong dest)
{
  return (jint)__gmpz_get_si( *((mpz_t*)dest));
}

/*
 * Class:     GmpUtil
 * Method:    mpz_cmp
 * Signature: (JJ)I
 */
JNIEXPORT jint JNICALL Java_GmpUtil_mpz_1cmp
  (JNIEnv *x, jclass y, jlong op1, jlong op2)
{
  return (jint) __gmpz_cmp( *((mpz_t*)op1), *((mpz_t*)op2) );
}

/*
 * Class:     GmpUtil
 * Method:    mpz_add
 * Signature: (JJJ)V
 */
JNIEXPORT void JNICALL Java_GmpUtil_mpz_1add
  (JNIEnv *x, jclass y, jlong dest, jlong src, jlong val)
{
  __gmpz_add( *((mpz_t*)dest), *((mpz_t*)src), *((mpz_t*)val) );
}

/*
 * Class:     GmpUtil
 * Method:    mpz_sub
 * Signature: (JJJ)V
 */
JNIEXPORT void JNICALL Java_GmpUtil_mpz_1sub
  (JNIEnv *x, jclass y, jlong dest, jlong src, jlong val)
{
  __gmpz_sub( *((mpz_t*)dest), *((mpz_t*)src), *((mpz_t*)val) );
}

/*
 * Class:     GmpUtil
 * Method:    mpz_mul_si
 * Signature: (JJI)V
 */
JNIEXPORT void JNICALL Java_GmpUtil_mpz_1mul_1si
  (JNIEnv *x, jclass y, jlong dest, jlong src, jint val)
{
  __gmpz_mul_si( *((mpz_t*)dest), *((mpz_t*)src), (long) val);
}

/*
 * Class:     GmpUtil
 * Method:    mpz_addmul_ui
 * Signature: (JJI)V
 */
JNIEXPORT void JNICALL Java_GmpUtil_mpz_1addmul_1ui
  (JNIEnv *x, jclass y, jlong dest, jlong a, jint b)
{
  __gmpz_addmul_ui( *((mpz_t*)dest), *((mpz_t*)a), (long)b);
}

/*
 * Class:     GmpUtil
 * Method:    mpz_submul_ui
 * Signature: (JJI)V
 */
JNIEXPORT void JNICALL Java_GmpUtil_mpz_1submul_1ui
  (JNIEnv *x, jclass y, jlong dest, jlong a, jint b)
{
  __gmpz_submul_ui( *((mpz_t*)dest), *((mpz_t*)a), (long)b);
}

/*
 * Class:     GmpUtil
 * Method:    mpz_divexact
 * Signature: (JJJ)V
 */
JNIEXPORT void JNICALL Java_GmpUtil_mpz_1divexact
  (JNIEnv *x, jclass y, jlong quot, jlong n, jlong d)
{
  __gmpz_divexact( *((mpz_t*)quot), *((mpz_t*)n), *((mpz_t*)d));
}

/*
 * Class:     GmpUtil
 * Method:    mpz_tdiv_qr
 * Signature: (JJJJ)V
 */
JNIEXPORT void JNICALL Java_GmpUtil_mpz_1tdiv_1qr
  (JNIEnv *x, jclass y, jlong q, jlong r, jlong n, jlong d)
{
  __gmpz_tdiv_qr( *((mpz_t*)q), *((mpz_t*)r), *((mpz_t*)n), *((mpz_t*)d) );
}

/*
 * Class:     GmpUtil
 * Method:    mpz_gcd
 * Signature: (JJJ)V
 */
JNIEXPORT void JNICALL Java_GmpUtil_mpz_1gcd
  (JNIEnv *x, jclass y, jlong r, jlong a, jlong b)
{
  __gmpz_gcd( *((mpz_t*)r), *((mpz_t*)a), *((mpz_t*)b) );
}
