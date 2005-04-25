#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: fibo.pike,v 1.3 2005-04-25 19:01:38 igouy-guest Exp $
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

