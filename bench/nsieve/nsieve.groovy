#!/bin/env groovy
/*
	$Id: nsieve.groovy,v 1.1 2005-09-18 05:01:24 igouy-guest Exp $

	The Great Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
	modified by 

	NSieve - Sieve of Eratosthenes

Each program should count the prime numbers from 2 to M, using the same nave Sieve of Eratosthenes algorithm:

    * create a sequence of M bits
    * for each index number
          o if the flag value at that index is true
                + set all the flag values at multiples of that index false
                + increment the count

Calculate 3 prime counts, for M = 2**N*10000, 2**N-1*10000, and 2**N-2*10000. Correct output N = 2 is:

Primes up to    40000    4203
Primes up to    20000    2262
Primes up to    10000    1229


The basic benchmark was described in "A High-Level Language Benchmark." BYTE, September 1981, p. 180, Jim Gilbreath.

For more information see Eric W. Weisstein, "Sieve of Eratosthenes." From MathWorld--A Wolfram Web Resource.
http://mathworld.wolfram.com/SieveofEratosthenes.html http://mathworld.wolfram.com/PrimeCountingFunction.html

        The NSieveBits sample is more groovy style than this fixed boolean array
*/

def nsieve(isPrime, m) {
        isPrime.each() {
                it = true
        }
        def count = 0
	for (i in 2..m) {
		if (isPrime[i]) {
                        (i+i..m).step(i) { j ->
				isPrime[j] = false
			}

                        count++
		}
	}
	count
}

def run(isPrime, n) {
        def m = 2**n*10000
	print("Primes up to ${m.toString().padLeft(8)}")
	println(nsieve(isPrime, m).toString().padLeft(8))
}

def n = args.length == 0 ? 2 : args[0].toInteger()
n = (int) Math.max(n, 2)

// Allocate once for all runs
def isPrime = [ true ] * (2**n*10000+1)

run(isPrime, n)
run(isPrime, n-1)
run(isPrime, n-2)

// EOF

