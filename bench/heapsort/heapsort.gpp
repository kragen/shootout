// -*- mode: c++ -*-
// $Id: heapsort.gpp,v 1.2 2004-11-30 07:10:03 bfulgham Exp $
// http://shootout.alioth.debian.org/
// C++-ified by Brent Fulgham

#include <iomanip>
#include <iostream>
#include <stdlib.h>
#include <math.h>

using namespace std;

#define IM 139968
#define IA   3877
#define IC  29573

double gen_random(double max) {
    static long last = 42;
    return( max * (last = (last * IA + IC) % IM) / IM );
}

void heapsort(int n, double *ra) {
    int i, j;
    int ir = n;
    int l = (n >> 1) + 1;
    double rra;

    for (;;) {
	if (l > 1) {
	    rra = ra[--l];
	} else {
	    rra = ra[ir];
	    ra[ir] = ra[1];
	    if (--ir == 1) {
		ra[1] = rra;
		return;
	    }
	}
	i = l;
	j = l << 1;
	while (j <= ir) {
	    if (j < ir && ra[j] < ra[j+1]) { ++j; }
	    if (rra < ra[j]) {
		ra[i] = ra[j];
		j += (i = j);
	    } else {
		j = ir + 1;
	    }
	}
	ra[i] = rra;
    }
}

int main(int argc, char *argv[]) {
    int N = ((argc == 2) ? atoi(argv[1]) : 1);
    
    /* create an array of N random doubles */
    double *ary = new double[ N+1 ];
    for (int i=1; i<=N; i++) {
	ary[i] = gen_random(1);
    }

    heapsort(N, ary);

    cout << std::fixed << std::setprecision(10);
    cout << ary[N] << endl;

    delete[] ary;
    return(0);
}

