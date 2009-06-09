/*
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 * contributed by Rex Kerr
 * algorithm follows Java version #4 by Anthony Donnefort
 */

object revcomp extends java.io.ByteArrayOutputStream {
  val input = new Array[Byte](8192)

  val table = new Array[Byte](128)
  for (i <- 0 to 127) { table(i) = i.toByte }
  for ((i,o) <- "ACGTUMRWSYKVHDB".toList zip "TGCAAKYWSRMBDHVN".toList) {
    table(i) = o.toByte
    table(i.toLowerCase) = o.toByte
  }

  def rcOut = {
    if (count > 0) {
      var begin = 0
      var end = count-1
      while (buf(begin) != '\n' && begin < count) { begin += 1 }
      while (begin <= end) {
        if (buf(begin) == '\n') begin += 1
        if (buf(end) == '\n') end -= 1
        if (begin<=end) {
          val temp = buf(begin)
          buf(begin) = table(buf(end))
          buf(end) = table(temp)
          begin += 1
          end -= 1
        }
      }
      System.out.write(buf,0,count)
    }
  }
  
  def main(args:Array[String]) = {
    var n = 0
    do {
      n = System.in.read(input)
      if (n > 0) {
        var i = 0
        var i0 = 0
        while (i < n) {
          if (input(i)=='>') {
            if (i>i0) write(input,i0,i-i0)
            rcOut
            reset
            i0 = i
          }
          i += 1
        }
        if (i0<n) write(input,i0,n-i0)
      }
    } while (n != -1)
    rcOut
  }
}
