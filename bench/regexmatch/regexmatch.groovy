#!/bin/env groovy
/*
	$Id: regexmatch.groovy,v 1.1 2005-09-18 05:01:25 igouy-guest Exp $

	The Great Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
	modified by 
    Each program should be implemented the same way - the same way as this Perl program.
    
    The regex benchmark measures regular expression pattern matching, extracting telephone numbers from a text.
    
    Each program should:
    
        * read text file
        * match the pattern against the file contents N times
        * print the text matches
    
    Correct output for this 1KB input file is:
    
    1: (111) 111-1111
    2: (111) 222-2222
    3: (111) 333-3333
    4: (111) 444-4444
    5: (111) 555-5555
    6: (111) 666-6666
    7: (111) 777-7777
    8: (111) 888-8888
    9: (111) 999-9999
    10: (111) 000-0000
    11: (111) 232-1111
    12: (111) 242-1111
    
    
    The telephone number pattern:
    
        * there may be zero or one telephone numbers per line of input
        * a telephone number may start at the beginning of the line or be preceeded by a non-digit, (which may be preceeded by anything)
        * it begins with a 3-digit area code that looks like this (DDD) or DDD (where D is [0-9])
        * the area code is followed by one space
        * which is followed by the 3 digits of the exchange: DDD
        * the exchange is followed by a space or hyphen [ -]
        * which is followed by the last 4 digits: DDDD
        * which can be followed by end of line or a non-digit (which may be followed by anything).

*/

def	pattern = "(^|^\\D*[^\\(\\d])"				+ // must be preceeded by non-digit
            "((\\(\\d\\d\\d\\))|(\\d\\d\\d))"	+ // match 2: Area Code inner match 3: area with perens,
            									  // inner match 4: without perens
            "[ ]"								+ // area code followed by one space
            "(\\d\\d\\d)"						+ //match 5: prefix of 3 digits
            "[ -]"								+ // prefix followed by space or dash
            "(\\d\\d\\d\\d)"					+ // match 6: last 4 digits
            "(\\D.*|\$)"						  // followed by non numeric chars

def N = (args.length == 0 ? 10 : args[0].toInteger())
def lines = System.in.readLines()

for (i in 1..N) { 
	def count = 0
	lines.each() {
		def matcher = it =~ pattern
		if (matcher.matches() && (i == 1)) {
			if (matcher.group(3) == null) {
				println "${++count}: (${matcher.group(4)}) ${matcher.group(5)}-${matcher.group(6)}"
			} else {
				println "${++count}: ${matcher.group(3)} ${matcher.group(5)}-${matcher.group(6)}"
			}
		}
	}
}

// EOF

