/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/

   contributed by Fredrik Roos
   modified by Fredrik Roos
*/

import scala.collection.immutable.TreeMap
import scala.io.Source

object ReverseComplement extends Application {

  val fromChars = "wsatugcyrkmbdhvnATUGCYRKMBDHVN".toList
  var toChars = "WSTAACGRYMKVHDBNTAACGRYMKVHDBN".toList

  val translateMap = (fromChars zip toChars).foldLeft(
     new TreeMap[Char, Char]) {
        case (map, (key, value)) => map(key) = value
  }

  def reverseComplement(s : String) =
    s.map(c => translateMap.getOrElse(c,c)).reverse.mkString("")

  def splitLines(lines : String, lineLength : Int) = 
     (0 to lines.length by lineLength).map(
        i => lines.slice(i, i + lineLength)).mkString("\n")

  Source.fromInputStream(System.in).getLines.foldLeft(List[String]()) {
    case (buffer, line) if line.startsWith(">") => {
      if (buffer.length > 0)
         println(splitLines(reverseComplement(buffer.mkString("")), 60))
      line.trim :: Nil
    }
    case (buffer, line) => buffer ::: line.trim :: Nil
  }
} 
