/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
   contributed by Jochen Hinrichsen
   The NSieveBits sample is more groovy style than this fixed boolean array
*/

def nsieve(isPrime, m) {
   isPrime.each() {
      it = true
   }

def count = 0
   for (i in 2..m) {
      if (isPrime[i]) {
         (i+i..m).step(i) { j ->
            isPrime[j] = false
         }
         count++
      }
   }
   count
}

def run(isPrime, n) {
   def m = 2**n*10000
   print("Primes up to ${m.toString().padLeft(8)}")
   println(nsieve(isPrime, m).toString().padLeft(9))
}

def n = args.length == 0 ? 2 : args[0].toInteger()
n = (int) Math.max(n, 2)

// Allocate once for all runs
def isPrime = [ true ] * (2**n*10000+1)

run(isPrime, n)
run(isPrime, n-1)
run(isPrime, n-2)


