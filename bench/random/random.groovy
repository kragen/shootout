#!/bin/env groovy
/*
	$Id: random.groovy,v 1.1 2005-09-18 05:01:25 igouy-guest Exp $

	The Great Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
	modified by 

	random

	Implement a function that generates a random double-precision floating point number using a linear congruential generator
	as described in Numerical Recipes in C by Press, Flannery, Teukolsky, Vetterling, section 7.1.

	S[j] = (A * S[j-1] + C) modulo M
	R = N * S[j] / M

	A (multiplier)
	C (increment)
	M (modulus)
	are appropriately chosen integral constants.

	S[j] (seed) is calculated from S[j-1]
	R (random number) is normalized to the interval [N,0].


	Correct output N = 1000 is

	8.163294467


	Each program should use symbolic constants (or whatever is closest) to define the A, C, and M constants in the algorithm,
	not literal constants. 

*/

def IM = 139968
def IA = 3877
def IC = 29573
def last = 42D

def gen_random(Double max) {
	last = (last * IA + IC) % IM
	max * last / IM
}

def n = (args.length == 0 ? 1 : args[0].toInteger()) - 1
while (n--) {
	gen_random(100D)
}

// TODO groovy does not support varargs
// def s = new java.io.PrintStream(System.out)
// s.printf("%.9f", gen_random(100D))

def nf = java.text.NumberFormat.getInstance()
nf.setMaximumFractionDigits(9)
nf.setMinimumFractionDigits(9)
nf.setGroupingUsed(false)
println nf.format(gen_random(100D))

// EOF

