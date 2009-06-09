/*
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 * contributed by Rex Kerr
 */

object revcomp {
  val table = new Array[Char](128)
  for (i <- 0 to 127) { table(i) = i.toChar }
  for ((i,o) <- "ACGTUMRWSYKVHDB".toList zip "TGCAAKYWSRMBDHVN".toList) {
    table(i) = o
    table(i.toLowerCase) = o
  }
  
  val buf = new StringBuilder
  def out {
    buf reverse;
    ".{1,60}".r findAllIn(buf) foreach(println _)
    buf clear
  }

  def main(args:Array[String]) = {
    io.Source.fromInputStream( System.in ).getLines.foreach(s => {
      if (s startsWith ">") {
        out
        print(s)
      }
      else s.trim.foreach(buf append table(_))
    })
    out
  }
}
