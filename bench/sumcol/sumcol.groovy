#!/bin/env groovy
/*
	$Id: sumcol.groovy,v 1.2 2005-09-23 15:11:35 igouy-guest Exp $

	The Great Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
*/

def sum = 0
System.in.eachLine() {
	sum += it.toInteger()
}
println sum

// EOF

