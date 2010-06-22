// The Computer Language Benchmarks Game
// http://shootout.alioth.debian.org/

// Contributed by The Anh Tran
// Updated for 2.8 by Rex Kerr

import scala.io.Source
import java.util.regex.Pattern
import scala.collection.immutable.HashMap
import scala.actors.Futures.future

object regexdna {

  def main(args : Array[String]) {

    // load data from stdin
    var input = Source.stdin.mkString
    val init_len = input length

    // strip header & newline
    input = ">.*\n|\n".r replaceAllIn(input, "")
    val strip_len = input length

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
    val count_results  = patterns map( pt => 
      future(pt.r.findAllIn(input).toArray.length)
    )

    // replace IUB
    val replace_result  = future {
      val iub = HashMap(
        'B' -> "(c|g|t)",
        'D' -> "(a|g|t)",
        'H' -> "(a|c|t)",
        'K' -> "(g|t)",
        'M' -> "(a|c)",
        'N' -> "(a|c|g|t)",
        'R' -> "(a|g)",
        'S' -> "(c|g)",
        'V' -> "(a|c|g)",
        'W' -> "(a|t)",
        'Y' -> "(c|t)"  )

      val buffer  = new StringBuffer((input.length * 3) / 2)
      val matcher  = Pattern compile "[BDHKMNRSVWY]" matcher input

      while ( matcher find )
        matcher appendReplacement( buffer, iub(input(matcher start))  )

      matcher appendTail buffer
      buffer length
    }


    // print results
    for ((pt, cres) <- patterns zip count_results)
      printf( "%s %d\n", pt, cres() )

    printf( "\n%d\n%d\n%d\n", init_len, strip_len, replace_result() )
  }
}
