/* The Computer Language Benchmarks Game
  http://shootout.alioth.debian.org/
  contributed by Rex Kerr
  based on Scala version by Isaac Gouy
  with optimization tricks from C version by Petr Prokhorenkov
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

  val IUBs = "acgtBDHKMNRSVWY"
  val IUBp = (
    Array(0.27,0.12,0.12,0.27) ++ Array.fill(11)(0.02)
  ).scanLeft(0.0)(_ + _).tail

  val HSs = "acgt"
  val HSp = Array(
    0.3029549426680, 0.1979883004921, 0.1975473066391, 0.3015094502008
  ).scanLeft(0.0)(_ + _).tail

  def main(args: Array[String]) = {
    val n = args(0).toInt
    val s = new FastaOutputStream(System.out)

    s.writeRepeating(ALU, n*2, "ONE Homo sapiens alu")
    s.writeRandom(IUBs, IUBp, n*3, "TWO IUB ambiguity codes")
    s.writeRandom(HSs, HSp, n*5, "THREE Homo sapiens frequency")

    s.close
  }
}


// extend the Java BufferedOutputStream class
class FastaOutputStream(out: OutputStream) extends BufferedOutputStream(out) {
  private val TableSize = 4096
  private val N = 60
  private val chunk = new Array[Byte](N+1)
  private val nl = '\n'.toByte

  // Tail-recursive; can check by prepending @annotation.tailrec
  private def writeRep(seq: Array[Byte], n: Int, off: Int = 0) {
    if (n > N) {
      val remains = seq.length - off
      // Assume seq.length >= N!
      if (remains>=N) {
        write(seq,off,N); write(nl)
        writeRep(seq, n-N, if (remains==N) 0 else off+N)
      }
      else {
        write(seq,off,remains); write(seq,0,N-remains); write(nl)
        writeRep(seq, n-N, 0+N-remains)
      }
    }
    else {
      for (i <- 0 until n) write(seq((i+off)%seq.length))
      write(nl)
    }
  }
  def writeRepeating(seq: String, n: Int, desc: String) {
    write( (">"+desc+"\n").getBytes )
    writeRep(seq.getBytes,n)
  }

  // Tail-recursive (check with @annotation.tailrec)
  private def writeRand(tab: Table, n: Int) {
    val m = if (n < N) { chunk(n) = nl; n } else N
    var i = 0
    while (i<m) {
      chunk(i) = tab.next
      i += 1
    }
    write(chunk,0,m+1)
    if (n > N) writeRand(tab, n-N)
  }
  def writeRandom(seq: String, dist: Array[Double], n: Int, desc: String) {
    write( (">"+desc+"\n").getBytes )
    chunk(N) = nl
    val tab = new Table(seq.getBytes, dist, TableSize)
    writeRand(tab,n)
  }

  // Constant time lookup table, assumes (1/size) < p(rarest entry)
  private class Table(bytes: Array[Byte], dist: Array[Double], size: Int) {
    abstract class X { def pick(d: Double): Byte }
    class B(b: Byte) extends X { def pick(d: Double) = b }
    class P(b0 : Byte, p: Double, b1: Byte) extends X {
      def pick(d: Double) = if (d < p) b0 else b1
    }

    def seek(p: Double): Int = {
      var i = 0
      while (i+1<dist.length && p >= dist(i)) i += 1
      i
    }
    var lastj = -1
    var lastX = null:X
    val lookup: Array[X] = (0 until size).map(i => {
      val (j0,j1) = (seek(i.toDouble/size), seek((i+1).toDouble/size))
      if (j0==j1) {
        if (lastj==j0) lastX
        else {
          lastX = new B(bytes(j0))
          lastj = j0
          lastX
        }
      }
      else {
        lastj = -1
        new P(bytes(j0),dist(j0),bytes(j1))
      }
    }).toArray
    
    def next = {
      val p = RandomNumber.next
      lookup((p*size).toInt).pick(p)
    }
  }

  private object RandomNumber {
    val (im,ia,ic) = (139968,3877,29573)
    val scale = 1.0/im
    var seed = 42
    def next = { seed = (seed * ia + ic) % im; seed*scale }
  }
}
