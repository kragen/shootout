// -*- mode: c++ -*-
// $Id: random.gpp,v 1.2 2005-05-26 06:51:07 bfulgham Exp $
// http://shootout.alioth.debian.org/

#include <iostream>
#include <stdlib.h>
#include <math.h>

using namespace std;

#define IM 139968
#define IA 3877
#define IC 29573

inline double gen_random(double max) {
    static long last = 42;
    last = (last * IA + IC) % IM;
    return( max * last / IM );
}

int main(int argc, char *argv[]) {
    int N = ((argc == 2) ? atoi(argv[1]) : 1);
    double result = 0;
    
    while (N-- > 1) {
	gen_random(100.0);
    }
    cout.precision(9);
    cout.setf(ios::fixed);
    cout << gen_random(100.0) << endl;
    return(0);
}

