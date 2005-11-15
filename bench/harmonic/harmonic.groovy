/*
	The Computer Language Shootout
	http://shootout.alioth.debian.org/
 
	contributed by Jochen Hinrichsen
*/

def n = (args.length == 0) ? 10**7 : args[0].toInteger()

def partialSum = 0d
for (i in 1..n) {
    partialSum += 1.0d / i
}
def f = new java.text.DecimalFormat("#." + "0" * 9)
println f.format(partialSum)

// EOF
