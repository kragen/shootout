#!/bin/env groovy
/*
	$Id: sumcol.groovy,v 1.1 2005-09-18 05:01:25 igouy-guest Exp $

	The Great Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
	modified by 

    Each program should be implemented the same way - the same way as this Icon program.
    
    The sum-file benchmark measures line-oriented I/O and string conversion.
    
    Each program should:
    
        * read integers from stdin, one line at a time
        * print the sum of those integers
    
    Correct output for this 6KB input file is:
    
    500
    
    
    Programs should use built-in line-oriented I/O functions rather than custom-code. No line will exceed 128 characters, including
	newline. Reading one line at a time, the programs should run in constant space.

*/

def sum = 0
System.in.eachLine() {
	sum += it.toInteger()
}
println sum

// EOF

