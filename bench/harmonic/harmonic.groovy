#!/bin/env groovy
/*
	$Id: harmonic.groovy,v 1.1 2005-09-18 05:01:24 igouy-guest Exp $

	The Great Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
	modified by 

    Each program should calculate the partial sum of the Harmonic series using the same naïve double-precision algorithm.
    
    Correct output N = 10,000,000 is:
    
    16.695311366
    
    
    For more information see Eric W. Weisstein, "Harmonic Series." From MathWorld--A Wolfram Web Resource.
    http://mathworld.wolfram.com/HarmonicSeries.html

*/

def n = (args.length == 0) ? 10**7 : args[0].toInteger()

def partialSum = 0d
for (i in 1..n) {
    partialSum += 1.0d / i
}
def f = new java.text.DecimalFormat("#." + "0" * 9)
println f.format(partialSum)

// EOF
