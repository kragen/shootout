/*
	The Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen

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
