/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
   contributed by Jochen Hinrichsen

*/

def nsieve(m) {
   def bits = new java.util.BitSet(m)
   bits.set(2, m, true)
   for (i in 2..m) {
      if (bits.get(i)) {
         (i+i..m).step(i) { j ->
            bits.clear(j)
         }
      }
   }
   bits.cardinality()	
}

def run(n) {
   int m = 2**n*10000
   print("Primes up to ${m.toString().padLeft(8)}")
   println(nsieve(m).toString().padLeft(9))
}

def n = args.length == 0 ? 2 : args[0].toInteger()
n = (int) Math.max(n, 2)

run(n)
run(n-1)
run(n-2)

