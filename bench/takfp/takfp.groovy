#!/bin/env groovy
/*
	$Id: takfp.groovy,v 1.1 2005-09-18 05:01:25 igouy-guest Exp $

	The Great Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
	modified by 

	Each program should calculate this TAK function using the same naïve floating-point recursive-algorithm

	TAK(x,y,z)
	  y < x   = TAK(TAK(x-1.0,y,z),TAK(y-1.0,z,x),TAK(z-1.0,x,y))
	    y >= x  = z


	Calculate TAK(N×3.0, N×2.0, N×1.0). Correct output N = 7 is:

	14.0


	Correct output N = 8 is:

	9.0


	Correct output N = 9 is:

	18.0


	Correct output N = 10 is:

	11.0


	The tak benchmark is described in Performance and Evaluation of Lisp Systems, Richard P. Gabriel, 1985, page 81. (1.1MB pdf)

	For more information see Eric W. Weisstein, "TAK Function." From MathWorld--A Wolfram Web Resource.
	http://mathworld.wolfram.com/TAKFunction.html

*/
def tak(x, y, z) {
	if (y >= x) return z
	return tak(tak(x-1, y, z), tak(y-1, z, x), tak(z-1, x, y))
}

def n = (args.length == 0 ? 7 : args[0].toFloat())
println tak(n*3, n*2, n*1)

// EOF


