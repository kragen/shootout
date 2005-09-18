#!/bin/env groovy
/*
	$Id: mandelbrot.groovy,v 1.1 2005-09-18 05:01:24 igouy-guest Exp $

	The Great Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
	modified by 

	Each program should plot the Mandelbrot set [-1.5-i,0.5+i] on an N-by-N
	bitmap. Write output byte-by-byte in portable bitmap format.

	Correct output N = 200 is in this 5KB output file.

	For more information see Eric W. Weisstein, "Mandelbrot Set." From
	MathWorld--A Wolfram Web Resource.
	http://mathworld.wolfram.com/MandelbrotSet.html

	Thanks to Greg Buchholz for this benchmark.
*/

int bit_num = byte_acc = 0
int iter = 50
double limit = 2.0

int h = w = (args.length == 0) ? 200 : args[0].toInteger()
println "P4\n${w} ${h}"
for (y in 0..<h) {
    for (x in 0..<w) {
        double Zr = Zi = 0.0
        double Cr = (2.0*x/w - 1.5)
        double Ci=(2.0*y/h - 1.0)

		def escape = false
		for (i in 1..iter) {
        	double Tr = Zr*Zr - Zi*Zi + Cr
            double Ti = 2.0*Zr*Zi + Ci
            Zr = Tr
			Zi = Ti
            if (Zr*Zr+Zi*Zi > limit*limit) {
				escape = true
				break
			}
        }

        byte_acc = (byte_acc << 1) | (escape ? 0x00 : 0x01)
        bit_num++

        if (bit_num == 8) {
            print((char) byte_acc)
            byte_acc = 0
            bit_num = 0
        } else if (x == w-1) {
            byte_acc = byte_acc << (8-w%8)
            print((char) byte_acc)
            byte_acc = 0
            bit_num = 0
        }
    }
}

// EOF

