#include "GmpInteger.h"
#include <gmp.h>
#include "jni.h"

JNIEXPORT void JNICALL Java_GmpInteger_mpz_1init
  (JNIEnv *env, jobject obj)
{
	__mpz_struct *ptr = new __mpz_struct();
	jlong pointer = (jlong)(ptr);
	jclass clazz = env->GetObjectClass( obj );
	jfieldID pointerField = env->GetFieldID(clazz,"pointer", "J");
	env->SetLongField(obj, pointerField, pointer);
	mpz_init( ptr );
}

JNIEXPORT void JNICALL Java_GmpInteger_mpz_1clear
  (JNIEnv *env, jobject obj, jlong pointer)
{
	__mpz_struct* ptr = (__mpz_struct*)pointer;
	mpz_clear(ptr);
	delete ptr;
}

/*
 * Class:     pidigits2_Gmp
 * Method:    mpz_init_set_ui
 * Signature: (Ljava/nio/ByteBuffer;J)V
 */
JNIEXPORT void JNICALL Java_GmpInteger_mpz_1set_1si
  (JNIEnv *env, jclass clzz, jlong dest, jint val)
{
	mpz_init_set_si( (__mpz_struct*)dest, val );
}


/*
 * Class:     pidigits2_Gmp
 * Method:    mpz_mul_si
 * Signature: (Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;J)V
 */
JNIEXPORT void JNICALL Java_GmpInteger_mpz_1mul_1si
  (JNIEnv *env, jclass clzz, jlong dest, jlong src, jint val)
{
	mpz_mul_si( (__mpz_struct*)dest,
	(__mpz_struct*)src,
	val);
}

/*
 * Class:     pidigits2_Gmp
 * Method:    mpz_add
 * Signature: (Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;)V
 */
JNIEXPORT void JNICALL Java_GmpInteger_mpz_1add
  (JNIEnv *env, jclass clzz, jlong dest, jlong src1, jlong src2)
{
	mpz_add( (__mpz_struct*)dest, (__mpz_struct*)src1, (__mpz_struct*)src2 );
}

/*
 * Class:     pidigits2_Gmp
 * Method:    __mpz_struct*div_q
 * Signature: (Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;)V
 */
JNIEXPORT void JNICALL Java_GmpInteger_mpz_1tdiv_1q
  (JNIEnv *env, jclass clzz, jlong dest, jlong src, jlong src2)
{ 
	mpz_tdiv_q( (__mpz_struct*)dest, (__mpz_struct*)src, (__mpz_struct*)src2 );
}

/*
 * Class:     pidigits2_Gmp
 * Method:    mpz_get_ui
 * Signature: (Ljava/nio/ByteBuffer;)J
 */
JNIEXPORT jint JNICALL Java_GmpInteger_mpz_1get_1si
  (JNIEnv *env, jclass clzz, jlong src)
{
	return mpz_get_si((__mpz_struct*)src);
}

/*
 * Class:     pidigits2_Gmp
 * Method:    mpz_get_d
 * Signature: (Ljava/nio/ByteBuffer;)D
 */
JNIEXPORT jdouble JNICALL Java_GmpInteger_mpz_1get_1d
  (JNIEnv *env, jclass clzz, jlong src)
{
	return mpz_get_d((__mpz_struct*)src);
}


