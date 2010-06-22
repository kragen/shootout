// The Computer Language Benchmarks Game
// http://shootout.alioth.debian.org/

// Contributed by The Anh Tran
// Updated for 2.8 by Rex Kerr

import scala.actors.Futures.future

object regexdna {

  def main(args: Array[String]) {
    var input = readAll
    val init_len = input length

    // strip header & newline
    input = """>.*\n|\n""".r replaceAllIn(input, "")
    val strip_len  = input length

    // counting patterns
    val patterns  = Array(
      "agggtaaa|tttaccct" ,
      "[cgt]gggtaaa|tttaccc[acg]",
      "a[act]ggtaaa|tttacc[agt]t",
      "ag[act]gtaaa|tttac[agt]ct",
      "agg[act]taaa|ttta[agt]cct",
      "aggg[acg]aaa|ttt[cgt]ccct",
      "agggt[cgt]aa|tt[acg]accct",
      "agggta[cgt]a|t[acg]taccct",
      "agggtaa[cgt]|[acg]ttaccct")

    // queue tasks, each task is handled in a separate thread
    val count_results = patterns map( pt => future(pt.r.findAllIn(input).length) )

    // replace IUB
    val replace_result = future {
    val iub = Array(
      "", "(c|g|t)", "", "(a|g|t)", "", "", "", "(a|c|t)",
      "", "", "(g|t)", "", "(a|c)", "(a|c|g|t)", "", "",
      "", "(a|g)", "(c|g)", "", "", "(a|c|g)", "(a|t)", "",
      "(c|t)"  )

      val buffer = new StringBuffer(input.length + (input.length >>> 1)) // input.len * 1.5
      val matcher = java.util.regex.Pattern compile "[BDHKMNRSVWY]" matcher input

      while ( matcher find )
        matcher appendReplacement( buffer, iub(input(matcher start) - 'A')  )

      matcher appendTail buffer
      buffer length
    }

    // print results
    for ((pt, cres) <- patterns zip count_results)
      printf( "%s %d\n", pt, cres() )

    printf( "\n%d\n%d\n%d\n", init_len, strip_len, replace_result() )
  }

  def readAll() = {
    // load data from stdin
    val reader = new java.io.InputStreamReader(System.in);

    val sb = new StringBuilder(64*1024*1024)
    val buf = new Array[Char](4 *1024*1024)
 
    Iterator.
      continually(reader read buf).
      takeWhile(_ != -1).
      foreach(n => sb.appendAll(buf, 0, n))

    sb toString
  }
}
