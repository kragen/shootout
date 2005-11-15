/*
	The Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
*/

def tak(x, y, z) {
	if (y >= x) return z
	return tak(tak(x-1, y, z), tak(y-1, z, x), tak(z-1, x, y))
}

def n = (args.length == 0 ? 7 : args[0].toFloat())
println tak(n*3, n*2, n*1)

// EOF


