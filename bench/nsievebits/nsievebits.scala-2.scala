/* The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy
*/

import scala.collection.mutable.BitSet

object nsievebits { 

   def nsieve(m: int) = {
      val sieved = new BitSet(m)
      sieved += 0
      sieved += 1

      var i = 2
      while (i < m){
         if (!sieved.contains(i)){
            var k = i+i
            while (k < m){ sieved += k; k = k+i }
         }

         i = i+1
      }
      m - sieved.size
   }


   def main(args: Array[String]) = {

      def printPrimes(m: int) = {

         def pad(i: int, width: int) = {
            val s = i.toString
            List.range(0, width - s.length)
               .map((i) => " ") .foldLeft("")((a,b) => a+b) + s 
         }

         Console.println("Primes up to " +  pad(m,8) + pad(nsieve(m),9))
      }

      val n = Integer.parseInt(args(0))
      printPrimes( (1<<n  )*10000 )
      printPrimes( (1<<n-1)*10000 )
      printPrimes( (1<<n-2)*10000 )
   } 
}
