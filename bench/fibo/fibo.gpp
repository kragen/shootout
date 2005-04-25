// -*- mode: c++ -*-
// $Id: fibo.gpp,v 1.3 2005-04-25 19:01:38 igouy-guest Exp $
// http://shootout.alioth.debian.org/

#include <iostream>
#include <stdlib.h>

using namespace std;

unsigned long fib(unsigned long n) {
    if (n < 2)
	return(1);
    else
	return(fib(n-2) + fib(n-1));
}

int main(int argc, char *argv[]) {
    int n = ((argc == 2) ? atoi(argv[1]) : 1);

    cout << fib(n) << endl;
    return(0);
}
