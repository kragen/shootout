/* ------------------------------------------------------------------ */
/* The Great Computer Language Shootout                               */
/* http://shootout.alioth.debian.org/                                 */
/*                                                                    */
/* Contributed by Anthony Borla                                       */
/* ------------------------------------------------------------------ */

import scala.collection.mutable.HashMap;

object knucleotide
{
  def main(args: Array[String]): unit =
  {
    val knuc: Knucleotide = new Knucleotide(loadSequence());

    knuc.printFrequencies(1);
    knuc.printFrequencies(2);

    knuc.printCount("GGT");
    knuc.printCount("GGTA");
    knuc.printCount("GGTATT");
    knuc.printCount("GGTATTTTAATT");
    knuc.printCount("GGTATTTTAATTTATAGT");
  } 

  // -------------

  def loadSequence(): String =
  {
    val buffer: StringBuffer = new StringBuffer();

    var line: String = Console.readLine;

    while (!line.startsWith(">THREE")) line = Console.readLine;

    line = Console.readLine;

    while (line != null)
    {
      buffer.append(line.toUpperCase); line = Console.readLine;
    }

    return buffer.toString();
  }
}

// -------------------------------

final class Knucleotide(_sequence: String)
{
  def printFrequencies(k: int): unit =
  {
    val countMap = generateCounts(k);
    val countSum = countMap.values.foldLeft[double](0.0)((x: double, y: int) => x + y);
    val freqList = countMap.toList.map((x) => Pair(x._1, x._2 / countSum * 100.0));
    val sortedFreqList = freqList.sort((x, y) => if (x._2 == y._2) x._1 > y._1 else x._2 > y._2);

    for (val Pair(k: String, v: double) <- sortedFreqList)
    {
      Console.printf("{0} {1,number,0.000}\n")(k, v);
    }

    Console.println;
  }

  // -------------

  def printCount(fragment: String): unit =
  {
    val countMap = generateCounts(fragment.length); var count = 0;

    if (countMap.contains(fragment)) count = countMap(fragment);

    Console.println(padl(count, 8, ' ') + fragment);
  }

  // -------------

  private def generateCounts(length: int): HashMap[String, int] =
  {
    val countMap: HashMap[String, int] = new HashMap();

    var i: int = 0; val last: int = sequence.length - length + 1;

    while (i < length)
    {
      var j: int = i;

      while (j < last)
      {
        var key: String = sequence.substring(j, j + length);

        if (countMap.contains(key))
          countMap.update(key, countMap(key) + 1); 
        else
          countMap(key) = 1;

        j = j + length;
      }

      i = i + 1;
    }

    return countMap;
  }

  // -------------

  private def padl(v: Any, padlen: int, padchar: char): String =
  {
    val s: String = "" + v; val reqlen: int = s.length() - padlen;
    return if (reqlen < 0) s + makeString(Math.abs(reqlen), padchar) else s; 
  }

  // -------------

  private def makeString(len: int, fillchar: char): String =
  {
    val sb: StringBuffer = new StringBuffer(); var i: int = 0;
    while (i < len) { sb.append(fillchar); i = i + 1; }
    return sb.toString();
  }

  // -------------

  private val sequence: String = _sequence;
}

