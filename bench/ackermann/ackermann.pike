#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: ackermann.pike,v 1.1 2004-05-19 18:09:09 bfulgham Exp $
// http://www.bagley.org/~doug/shootout/

int Ack(int M, int N) {
  if (M == 0) return( N + 1 );
  if (N == 0) return( Ack(M - 1, 1) );
  return( Ack(M - 1, Ack(M, (N - 1))) );
}

int main(int argc, array(string) argv) {
  int N = (int)argv[-1] || 1;
  write("Ack(3,%d): %d\n", N, Ack(3, N));
}
