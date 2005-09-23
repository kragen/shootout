#!/bin/env groovy
/*
	$Id: regexmatch.groovy,v 1.2 2005-09-23 15:11:35 igouy-guest Exp $

	The Great Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
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

