/*
	The Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
*/

public class frequency {
    @Property String s
    @Property c, p

	// Store string representation as Byte
	public void setS(String rep) {
		s = rep
		// Cannot call def method from here, aborts without warning/ error
		c = rep.getBytes()[0]
	}

}

def NEWLINE = "\n".getBytes()[0]

def LINE_LENGTH = 60

// Weighted selection from alphabet
def ALU = "GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG" +
"GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA" +
"CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT" +
"ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA" +
"GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG" +
"AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC" +
"AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA"
def ALUB = ALU.getBytes()

def IUB = [
        new frequency(s:'a', p:0.27d),
        new frequency(s:'c', p:0.12d),
        new frequency(s:'g', p:0.12d),
        new frequency(s:'t', p:0.27d),

        new frequency(s:'B', p:0.02),
        new frequency(s:'D', p:0.02),
        new frequency(s:'H', p:0.02),
        new frequency(s:'K', p:0.02),
        new frequency(s:'M', p:0.02),
        new frequency(s:'N', p:0.02),
        new frequency(s:'R', p:0.02),
        new frequency(s:'S', p:0.02),
        new frequency(s:'V', p:0.02),
        new frequency(s:'W', p:0.02),
        new frequency(s:'Y', p:0.02)
]

def HomoSapiens = [
        new frequency(s:'a', p:0.3029549426680d),
        new frequency(s:'c', p:0.1979883004921d),
        new frequency(s:'g', p:0.1975473066391d),
        new frequency(s:'t', p:0.3015094502008d)
]

def BUFFER_SIZE = 8192
def index = 0
def bbuffer = new byte[BUFFER_SIZE]

// pseudo-random number generator
def IM = 139968
def IA = 3877
def IC = 29573
def last = 42

def random(def max) {
    last = (last * IA + IC) % IM
    max * last / IM
}


def makeCumulative(a) {
        def cp = 0.0d
        for (i in 0..<a.size()) {
            cp += a[i].p
            a[i].p = cp
        }
}

// select a random frequency.c
def selectRandom(a) {
    def len = a.size()
    def r = random(1.0d)
    for (i in 0..<len)
        if (r < a[i].p)
            return a[i].c
    return a[len - 1].c
}

def makeRepeatFasta(id, desc, alu, n, writer) {
	index = 0
	int m = 0
	int k = 0
	int kn = ALUB.length
	writer << ">" + id + " " + desc + "\n"
	while (n > 0) {
			m = (n < LINE_LENGTH) ? n : LINE_LENGTH
			if (BUFFER_SIZE - index < m){
					writer.write(bbuffer, 0, index)
					index = 0
			}
			for (i in 0..<m) {
					if (k == kn) k = 0
					bbuffer[index++] = ALUB[k]
					k++
			}
			bbuffer[index++] = NEWLINE
			n -= LINE_LENGTH
	}
	if(index != 0) writer.write(bbuffer, 0, index)
}

def makeRandomFasta(id, desc, a, n, writer) {
	index = 0
	int m = 0
	writer << ">" + id + " " + desc + "\n"
	while (n > 0) {
			m = (n < LINE_LENGTH) ? n : LINE_LENGTH
			if (BUFFER_SIZE - index < m){
					writer.write(bbuffer, 0, index)
					index = 0
			}
			for (i in 0..<m) {
					bbuffer[index++] = selectRandom(a)
			}
			bbuffer[index++] = NEWLINE
			n -= LINE_LENGTH
	}
	if(index != 0) writer.write(bbuffer, 0, index)
}


makeCumulative(HomoSapiens)
makeCumulative(IUB)

def n = args.length == 0 ? 2500000 : args[0].toInteger()
def out = new BufferedOutputStream(System.out)

makeRepeatFasta("ONE", "Homo sapiens alu", ALU, n * 2, out)
makeRandomFasta("TWO", "IUB ambiguity codes", IUB, n * 3, out)
makeRandomFasta("THREE", "Homo sapiens frequency", HomoSapiens, n * 5, out)
out.flush()

// EOF

