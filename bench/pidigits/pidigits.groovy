/*
	The Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen

	Trailing 'G' stands for BigInteger (unrestricted size) in groovy
*/

class T {

	public q, r, s, t, k = 0G

	def compose(t2) {
		new T(q: q * t2.q,
			r: q * t2.r + r * t2.t,
			s: s * t2.q + t * t2.s,
			t: s * t2.r + t * t2.t)
	}

	def extract(j) {
		// groovy does not support integer division using /
		(q*j + r).divide(s*j + t)
	}

	def next() {
		k++
		q = k
		r = 4G*k+2G
		s = 0G
		t = 2G*k+1G

		this
	}
}

class Digits {

    def x = new T(q:0G, r:0G, s:0G, t:0G)
    def z = new T(q:1G, r:0G, s:0G, t:1G)

	private consume(T t) {
		z.compose(t)
	}

	private digit() {
		z.extract(3G)
	}

	private isSafe(digit) {
		digit == z.extract(4G)
	}

	def next() {
		def y = digit()
		if (isSafe(y)) {
			z = produce(y)
			return y
		} else {
			z = consume(x.next())
			return next()
		}
	}

	private produce(y) {
        new T(q:10G, r:-10G*y, s:0G, t:1G).compose(z)
	}
}

def L = 10
def n = (args.length == 0) ? 10 : args[0].toInteger()
def digits = new Digits()
def j = 0
while (n > 0){
	if (n >= L) {
		for (i in 0..<L) print digits.next()
		j += L
	} else {
		for (i in 0..<n) print digits.next()
		print(" " * (L-n-1))
		j += n;
	}
	print("\t:");
	println j
	n -= L;
}

// EOF

