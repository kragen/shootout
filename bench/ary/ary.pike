#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: ary.pike,v 1.2 2004-05-22 07:25:00 bfulgham Exp $
// http://www.bagley.org/~doug/shootout/

void main(int argc, array(string) argv)
{
    int n = (int)argv[-1];
    if (n < 1) n = 1;

    array(int) x = allocate(n);
    array(int) y = allocate(n);

    for (int i; i<n; i++) {
	x[i] = i + 1;
    }
    for (int k; k<1000; k++) {
	for (int i=n-1; i>=0; i--) {
	    y[i] += x[i];
	}
    }
    write("%d %d\n", y[0], y[-1]);
}
