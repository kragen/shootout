/*
	The Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
*/

def sum = 0
System.in.eachLine() {
	sum += it.toInteger()
}
println sum

// EOF

