#!/bin/env groovy
/*
	$Id: heapsort.groovy,v 1.1 2005-09-18 05:01:24 igouy-guest Exp $

	The Great Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
	modified by 

    Each program should be implemented the same way - the same way as this C program.
    
    Programs implement an in-place heapsort function that takes arguments (N, ARY), where N is the number of elements in the array
	ARY, starting from index 1. ARY is passed by reference.
    
    Correct output N = 1000 is:
    
    0.9990640718
    
    
    The heapsort algorithm is from Numerical Recipes in C, section 9.2, page 247. Initialize the array with random double-precision
	floating point numbers using the naive (and lightweight) pseudo-random number generator from the random benchmark.
*/
    public static final long IM = 139968
    public static final long IA =   3877
    public static final long IC =  29573

    public static long last = 42
    def gen_random(double max) {
		max * (last = (last * IA + IC) % IM) / IM
    }

    def heapsort(int n, double[] ra) {
		int l, j, ir, i
		double rra

		l = (n >> 1) + 1
		ir = n
		while (true) {
		    if (l > 1) {
				rra = ra[--l]
		    } else {
				rra = ra[ir]
				ra[ir] = ra[1]
				if (--ir == 1) {
				    ra[1] = rra
				    return
				}
		    }
		    i = l
		    j = l << 1
		    while (j <= ir) {
				if (j < ir && ra[j] < ra[j+1]) { ++j }
				if (rra < ra[j]) {
				    ra[i] = ra[j]
				    j += (i = j)
				} else {
				    j = ir + 1
				}
		    }
		    ra[i] = rra
		}
    }

def N = (args.length == 0) ? 1000 : args[0].toInteger()
def nf = java.text.NumberFormat.getInstance()
nf.setMaximumFractionDigits(10)
nf.setMinimumFractionDigits(10)
nf.setGroupingUsed(false)
double []ary = (double[]) java.lang.reflect.Array.newInstance(double.class, N+1)
for (i in 0..<N) {
    ary[i] = gen_random(1)
}
heapsort(N, ary)
println nf.format(ary[N])

// EOF

