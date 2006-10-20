/* The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy
*/

import java.io._

object fasta { 
   def main(args: Array[String]) = {

      val _ALU =
         "GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG" +
         "GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA" +
         "CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT" +
         "ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA" +
         "GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG" +
         "AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC" +
         "AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA"

      val ALU = _ALU.getBytes

      val _IUB = Array(
         Pair('a', 0.27), 
         Pair('c', 0.12), 
         Pair('g', 0.12), 
         Pair('t', 0.27), 

         Pair('B', 0.02), 
         Pair('D', 0.02),
         Pair('H', 0.02), 
         Pair('K', 0.02), 
         Pair('M', 0.02),
         Pair('N', 0.02), 
         Pair('R', 0.02), 
         Pair('S', 0.02),
         Pair('V', 0.02), 
         Pair('W', 0.02), 
         Pair('Y', 0.02)
      )

      val IUB = makeCumulative(_IUB)

      val _HomoSapiens = Array(
         Pair('a', 0.3029549426680), 
         Pair('c', 0.1979883004921),
         Pair('g', 0.1975473066391), 
         Pair('t', 0.3015094502008)
      )

      val HomoSapiens = makeCumulative(_HomoSapiens)


      var n = Integer parseInt(args(0))
      val w = new BufferedOutputStream(System.out)

      makeRepeatFasta("ONE", "Homo sapiens alu", ALU, n*2, w)
      makeRandomFasta("TWO", "IUB ambiguity codes", IUB, n*3, w)
      makeRandomFasta("THREE", "Homo sapiens frequency", HomoSapiens, n*5, w)

      w.close
   } 


   class Frequency(_code: byte, _percent: double){ 
      var code = _code; var percent = _percent;
   }

   def makeCumulative(a: Array[Pair[Char,double]]) = {
      var cp = 0.0
      a map (frequency =>
         frequency match { 
            case Pair(code,percent) => 
               cp = cp + percent; new Frequency(code.toByte,cp) 
         } 
      )
   }


   val LineLength = 60

   def makeRandomFasta(id: String, desc: String, a: Array[Frequency],
          _n: int, w: BufferedOutputStream) = {

      def selectRandom(): Byte = {
         val n = a.length
         val r = RandomNumber scaledTo(1.0)

         var i = 0
         while (i < n) {
            if (r < a(i).percent) return a(i).code
            i = i+1
         }
         return a(n-1).code
      }

      w.write((">" + id + " " + desc + "\n").getBytes )

      val nl = '\n'.toByte
      var n = _n
      while (n > 0) {
         val m = if (n < LineLength) n else LineLength

         var i = 0
         while (i < m){ 
            w write( selectRandom() )
            i = i+1 
         }

         w write(nl)
         n = n - LineLength
      }
   }


   def makeRepeatFasta(id: String, desc: String, alu: Array[byte],
          _n: int, w: BufferedOutputStream) = 
   {
      var n = _n; var k = 0; val kn = alu.length;
      val nl = '\n'.toByte
      w write((">" + id + " " + desc + "\n").getBytes )
      
      while (n > 0) {
         val m = if (n < LineLength) n else LineLength

         var i = 0
         while (i < m){ 
            if (k == kn) k = 0
            w write( alu(k) )
            k = k+1

            i = i+1 
         }

         w write(nl)
         n = n - LineLength
      }
   }
}


object RandomNumber {
   private val IM = 139968
   private val IA = 3877
   private val IC = 29573
   private var seed = 42

   def scaledTo(max: double) = {
      seed = (seed * IA + IC) % IM
      max * seed / IM
   }
}
