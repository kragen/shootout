#!/usr/bin/env groovy
/*
	$Id: ackermann.groovy,v 1.2 2005-09-21 05:40:33 bfulgham Exp $

	The Great Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
	modified by 

	Ackermann

	Each program should calculate the Ackermann function using the same naïve recursive-algorithm

	A(x,y)
	  x = 0     = y+1
	  y = 0     = A(x-1,1)
 	  otherwise = A(x-1, A(x,y-1))
 
 
 	  Calculate A(3,N). Correct output N = 4 is:
 
 	  A(3,4): 125
 
 
 	  The Ackermann benchmark is described in Timing Trials, or, the Trials of Timing: Experiments with Scripting and User-Interface Languages.
 
 	  For more information see Eric W. Weisstein, "Ackermann Function." From MathWorld--A Wolfram Web Resource.
 	  http://mathworld.wolfram.com/AckermannFunction.html
*/

def A(x, y) {
	// TODO: return statement is stated optional, but does not work w/o
	if (x == 0) return y+1
	if (y == 0) return A(x-1, 1)
	return A(x-1, A(x, y-1))
}

def n = this.args[0].toInteger()
def result = A(3, n)
println("A(3, ${n}): ${result}")

