#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

/* we put an auxillary C function here to do the actual recursive
   calculation */
int Ack1(int M, int N) {
    if (M == 0) { return(N + 1); }
    if (N == 0) { return(Ack1(M - 1, 1)); }
    return(Ack1(M - 1, Ack1(M, (N - 1))));
}


MODULE = Ackermann		PACKAGE = Ackermann		


int
Ack(int M, int N)
    CODE:
	RETVAL = Ack1(M, N);
    OUTPUT:
	RETVAL

