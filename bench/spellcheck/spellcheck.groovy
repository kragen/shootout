#!/bin/env groovy
/*
	$Id: spellcheck.groovy,v 1.1 2005-09-18 05:01:25 igouy-guest Exp $

	The Great Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
	modified by 

        Each program should be implemented the same way - the same way as this Lua program.

        The spellcheck benchmark measures line oriented I/O and hash table (associative array) performance.

        Each program should:

            * read the word dictionary
            * read words from standard input and print those words which do not appear in the dictionary

        Correct output for this 345KB input file with this 345KB Usr.Dict.Words file is:

        zuul
        zuul
        zuul
        zuul
        zuul


        Assume that for both the dictionary and standard input there is only one word per line. The dictionary is based on /usr/dict/words, but we only use words that consist entirely of lowercase letters. Each program can assume that no line will exceed 128 characters (including newline).

*/

def dict = [:]

new File("spellcheck-dict.txt").eachLine() {
        dict[it] = true
}

System.in.eachLine() {
        if (!dict[it]) println it
}

// EOF
