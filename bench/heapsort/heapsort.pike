#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: heapsort.pike,v 1.1 2004-05-19 18:10:10 bfulgham Exp $
// http://www.bagley.org/~doug/shootout/
// from: Fredrik Noring

#define IM 139968
#define IA   3877
#define IC  29573

int last = 42;

float
gen_random(float max) { return(max * (last = (last * IA + IC) % IM) / IM); }

void heapsort(int n, array(float) ra) {
    int l, j, ir, i;
    float rra;

    l = (n >> 1) + 1;
    ir = n;
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

void main(int argc, array(string) argv) {
    int N = (int)argv[-1] || 1;
    array(float) ary;
    int i;
    
    // create an array of N random floats
    ary = allocate(N+1);
    for (i=1; i<=N; i++) {
        ary[i] = gen_random(1.0);
    }

    heapsort(N, ary);

    write("%.10f\n", ary[N]);
}
