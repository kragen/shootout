#include <jni.h>
#include "ack.h"


int
Ack(jint M, jint N) {
   if(M == 0) return(N + 1);
   if(N == 0) return(Ack(M - 1, 1));
   return(Ack(M - 1, Ack(M, (N - 1))));
}

JNIEXPORT jint JNICALL 
Java_ack_Ack(JNIEnv *env, jclass obj, jint m, jint n) {
   return Ack(m, n);
}


