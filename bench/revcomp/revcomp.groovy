#!/bin/env groovy
/*
	$Id: revcomp.groovy,v 1.2 2005-09-23 15:11:35 igouy-guest Exp $

	The Great Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
*/

def complements = ['A':'T', 'C':'G', 'G':'C', 'T':'A', 'M':'K', 'R':'Y', 'W':'W', 'S':'S', 'Y':'R', 'K':'M', 'V':'B', 'H':'D', 'D':'H', 'B':'V', 'N':'N']

def revComp(s) {
    def rev = ""
    s.toUpperCase().each() {
        def ch = complements[it]
        if (ch == null) {
            println ""
            println (it)
        }
        rev += ch
    }
    rev
}

System.in.newReader().eachLine() { line ->
    println (line.startsWith(">") ? line : revComp(line))
}

// EOF
