#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: fibo.pike,v 1.1 2004-05-19 18:09:49 bfulgham Exp $
// http://www.bagley.org/~doug/shootout/

int
fib(int n) {
    if (n < 2) return(1);
    return( fib(n-2) + fib(n-1) );
}

void
main(int argc, array(string) argv) {
    int n = max((int)argv[-1], 1);
    write("%d\n", fib(n));
}

