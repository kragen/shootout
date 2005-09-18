#!/bin/env groovy
/*
	$Id: spectralnorm.groovy,v 1.1 2005-09-18 05:01:25 igouy-guest Exp $

	The Great Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
	modified by 

	Each program should calculate the spectral norm of an infinite matrix A, with entries a11=1, a12=1/2, a21=1/3, a13=1/4, a22=1/5, a31=1/6, etc

	Each program must implement 4 separate functions / procedures / methods like the C# program.

	Correct output N = 100 is:

	1.274219991


	For more information see challenge #3 in Eric W. Weisstein, "Hundred-Dollar, Hundred-Digit Challenge Problems" and "Spectral Norm"

	From MathWorld--A Wolfram Web Resource.
	http://mathworld.wolfram.com/Hundred-DollarHundred-DigitChallengeProblems.html
	http://mathworld.wolfram.com/SpectralNorm.html

	Thanks to Sebastien Loisel for this benchmark.

	as double:		28s
	as Double:		28s
	.0D:			24s
	as double[]:	25s

*/
def approximate(n) {
    // create unit vector
	def u = [1.0D] * n

    // 20 steps of the power method
	def v = [0.0D] * n

    for (i in 1..10) {
        MultiplyAtAv(n,u,v)
        MultiplyAtAv(n,v,u)
    }

    // B=AtA         A multiplied by A transposed
    // v.Bv /(v.v)   eigenvalue of v
    double vBv = vv = 0.0D
    for (i in 0..<n) {
        vBv += u[i]*v[i]
        vv  += v[i]*v[i]
    }

    return Math.sqrt(vBv/vv)
}


/* return element i,j of infinite matrix A */
def A(i, j) {
    return (1.0D) / ((i+j)*(i+j+(1.0D))/(2.0D) +i+(1.0D))
}

/* multiply vector v by matrix A */
def MultiplyAv(n, v, Av){
    for (i in 0..<n) {
        Av[i] = 0.0D
        for (j in 0..<n) Av[i] += A(i,j)*v[j]
    }
}

/* multiply vector v by matrix A transposed */
def MultiplyAtv(n, v, Atv){
    for (i in 0..<n) {
        Atv[i] = 0.0D
        for (j in 0..<n) Atv[i] += A(j,i)*v[j]
    }
}

/* multiply vector v by matrix A and then by matrix A transposed */
def MultiplyAtAv(n, v, AtAv){
    double[] u = new double[n]
    MultiplyAv(n, v, u)
    MultiplyAtv(n, u, AtAv)
}

def n = (args.length == 0 ? 100 : args[0].toInteger())
def nf = java.text.NumberFormat.getInstance()
nf.setMaximumFractionDigits(9)
nf.setMinimumFractionDigits(9)
nf.setGroupingUsed(false)
println(nf.format(approximate(n)))

// EOF

