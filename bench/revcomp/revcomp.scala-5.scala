/*
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 * contributed by Rex Kerr
 */

object revcomp {
  def hl(s: String) = s + s.toLowerCase
  val table = Map( (hl("ACGTUMRWSYKVHDBN") zip ("TGCAAKYWSRMBDHVN"*2)): _* )

  val buf = new collection.mutable.ArrayBuffer[Char]
  def out {
    buf.reverseIterator.grouped(60).foreach( s => println(s.mkString) )
    buf clear
  }

  def main(args:Array[String]) = {
    io.Source.stdin.getLines().foreach(s => {
      if (s startsWith ">") {
        out
        println(s)
      }
      else buf ++= s.map(table(_))
    })
    out
  }
}
