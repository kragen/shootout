/* The Computer Language Shootout
  http://shootout.alioth.debian.org/
  contributed by Isaac Gouy
  modified and updated for 2.8 by Rex Kerr
*/

import java.io._

object regexdna {
  def main(args: Array[String]) {

    var sequence = readFully()
    val initialLength = sequence.length

    def matching(s: String) = java.util.regex.Pattern.compile(s).matcher(sequence)

    // remove FASTA sequence descriptions and new-lines
    sequence = matching(">.*\n|\n").replaceAll("")
    val codeLength = sequence.length

    // regex match
    Array(
      "agggtaaa|tttaccct",
      "[cgt]gggtaaa|tttaccc[acg]",
      "a[act]ggtaaa|tttacc[agt]t",
      "ag[act]gtaaa|tttac[agt]ct",
      "agg[act]taaa|ttta[agt]cct",
      "aggg[acg]aaa|ttt[cgt]ccct",
      "agggt[cgt]aa|tt[acg]accct",
      "agggta[cgt]a|t[acg]taccct",
      "agggtaa[cgt]|[acg]ttaccct"
    ).map(v => {
      var count = 0
      val m = matching(v)
      while (m.find()) count += 1
      println(v + " " + count)
    })

    // regex substitution
    Array(
      ("B", "(c|g|t)"),
      ("D", "(a|g|t)"),
      ("H", "(a|c|t)"),
      ("K", "(g|t)"),
      ("M", "(a|c)"),
      ("N", "(a|c|g|t)"),
      ("R", "(a|g)"),
      ("S", "(c|g)"),
      ("V", "(a|c|g)"),
      ("W", "(a|t)"),
      ("Y", "(c|t)")
    ).foreach(iub => sequence = matching(iub._1).replaceAll(iub._2) )

    println("\n" + initialLength + "\n" + codeLength + "\n" + sequence.length)
  }

  def readFully() = {
    val block = new Array[Char](10240)
    val buffer = new StringBuffer
    val r = new InputStreamReader(System.in)

    Iterator.
      continually(r.read(block)).
      takeWhile(_ > -1).
      foreach(n => buffer.append(block,0,n))

   r.close
   buffer.toString
  }
}
