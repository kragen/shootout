/* The Computer Language Shootout
  http://shootout.alioth.debian.org/
  contributed by Isaac Gouy
  updated for 2.8 and modified by Rex Kerr
*/

import java.io._

object fasta {
  val ALU =
    "GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG" +
    "GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA" +
    "CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT" +
    "ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA" +
    "GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG" +
    "AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC" +
    "AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA"

  val IUB = (Array( ('a',0.27), ('c',0.12), ('g',0.12), ('t',0.27) ) ++
    "BDHKMNRSVWY".map(c => (c,0.02))
  ).scanLeft( (0:Byte,0.0) )( (l,r) => (r._1.toByte, l._2+r._2) ).tail

  val HomoSapiens = Array(
    ('a', 0.3029549426680),
    ('c', 0.1979883004921),
    ('g', 0.1975473066391),
    ('t', 0.3015094502008)
  ).scanLeft( (0:Byte,0.0) )( (l,r) => (r._1.toByte, l._2+r._2) ).tail

  def main(args: Array[String]) = {
    val n = args(0).toInt
    val s = new FastaOutputStream(System.out)

    s.writeDescription("ONE Homo sapiens alu")
    s.writeRepeatingSequence(ALU,n*2)

    s.writeDescription("TWO IUB ambiguity codes")
    s.writeRandomSequence(IUB,n*3)

    s.writeDescription("THREE Homo sapiens frequency")
    s.writeRandomSequence(HomoSapiens,n*5)

    s.close
  }
}


// extend the Java BufferedOutputStream class

class FastaOutputStream(out: OutputStream) extends BufferedOutputStream(out) {
  private val LineLength = 60
  private val nl = '\n'.toByte

  def writeDescription(desc: String) = { write( (">" + desc + "\n").getBytes ) }

  def writeRepeatingSequence(_alu: String, length: Int) = {
    val alu = _alu.getBytes
    var n = length; var k = 0; val kn = alu.length;

    while (n > 0) {
      val m = if (n < LineLength) n else LineLength

      var i = 0
      while (i < m){
        if (k == kn) k = 0
        val b = alu(k)
        if (count < buf.length){ buf(count) = b; count += 1 }
        else { write(b) } // flush buffer
        k += 1
        i += 1
      }

      write(nl)
      n -= LineLength
    }
  }

  def writeRandomSequence(distribution: Array[(Byte,Double)], length: Int) = {
    var n = length
    while (n > 0) {
      val m = if (n < LineLength) n else LineLength

      var i = 0
      while (i < m){
        val b = selectRandom(distribution)
        if (count < buf.length) { buf(count) = b; count += 1 }
        else { write(b) } // flush buffer
        i += 1
      }

      if (count < buf.length){ buf(count) = nl; count += 1 }
      else { write(nl) } // flush buffer
      n -= LineLength
    }
  }

  private def selectRandom(distribution: Array[(Byte,Double)]): Byte = {
    val n = distribution.length
    val r = RandomNumber scaledTo(1.0)

    var i = 0
    while (i < n) {
      if (r < distribution(i)._2) return distribution(i)._1
      i = i+1
    }
    return distribution(n-1)._1
  }
}


object RandomNumber {
  val IM = 139968
  val IA = 3877
  val IC = 29573
  private var seed = 42

  def scaledTo(max: Double) = {
    seed = (seed * IA + IC) % IM
    max * seed / IM
  }
}
