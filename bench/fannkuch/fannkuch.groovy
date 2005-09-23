#!/bin/env groovy
/*
	$Id: fannkuch.groovy,v 1.2 2005-09-23 15:11:34 igouy-guest Exp $

	The Great Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
*/

// This algorithm taken from the ruby sample does not produce the exact order as defined above
def permute(head, tail, permute) {
	for (i in 0..<tail.size()) {
		head.add(tail.remove(i))
		tail.isEmpty() ? permute(head.clone()) : permute(head, tail, permute)
		tail.add(i, head.pop())
	}
}

def permute(size, closure) {
	permute([], (1..size).step(1), closure)
}

def N = (args.length == 0) ? 7 : args[0].toInteger()
def maxflips = 0

permute(N) { |list|
	def flips = 0
	while ((count = list[0]) != 1) {
		// Inconsistent groovy syntax, lvalue list[0..<count] does not work
		// Option #1
		// list[0, count-1] = list[0..<count].reverse()

		// Option #2: more Java like alternative, little bit faster
		Collections.copy(list, list[0..<count].reverse())

		flips++
	}
	maxflips = [maxflips, flips].max()
}

println "Pfannkuchen(${N}) = ${maxflips}"

// EOF

