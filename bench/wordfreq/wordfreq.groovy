#!/bin/env groovy
/*
	$Id: wordfreq.groovy,v 1.1 2005-09-18 05:01:25 igouy-guest Exp $

	The Great Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
	modified by 

    Each program should do the same thing.
    
    Each program should:
    
        * read a text file from stdin
        * extract all the words
        * convert the words to lowercase
        * calculate the frequency of each word in the text file
        * print each word and word frequency, in descending order by frequency and descending alphabetic order by word
    
    Correct output for this 170KB input file is in this 50KB output file.
    
    Programs should use constant space over a range of input sizes. Programs may read the input file line-by-line, or with 4096 byte (or smaller) block reads.
    
    The input file to the tests is the text file The Prince, by Nicoló Machiavelli.
    
    (The bash program is really a pipeline using tr, grep, sort and uniq. This is the UNIX way of combining tools in the shell to get things done.)
*/

// def dict = [:]
def dict = new TreeMap()

// read input, build dictionary
System.in.eachLine() { line ->
	// split on words
	line.split("\\W").each() { word ->
		def s = word.toLowerCase()
		def entry = dict[s]
		dict[s] = (entry == null) ? 1 : entry+1
	}
}

// default sort() is smallest first
// sort for multiple properties: [ it.value, it.key ]
assert dict != null
assert dict.values() != null
assert (dict.values().sort({ l, r -> r <=> l})) != null
dict.values().sort({ l, r -> r <=> l}).each() { value ->
/*
	assert value != null
    def entry = dict.find() { e ->
        def v = e.getValue()
		assert v != null
        e.getValue() == value
    }
	assert entry != null
*/
    // println "${value.toString().padLeft(8)} ${entry.key}"
    println "${value.toString().padLeft(8)}"
}

// EOF

