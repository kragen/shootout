/* ------------------------------------------------------------------ */
/* The Great Computer Language Shootout                               */
/* http://shootout.alioth.debian.org/                                 */
/*                                                                    */
/* Modelled on Pike version                                           */
/*                                                                    */
/* Contributed by Anthony Borla                                       */
/* ------------------------------------------------------------------ */

import java.util.regex._;

object regexdna
{
  def main(args: Array[String]): unit =
  {
    // Read input data into string and record its length
    var sequence: String = loadSequence;
    val initial_length: int = sequence.length;

    // Remove newline and segment divider line occurrences; record new length
    sequence = Pattern.compile(">.*\n|\n").matcher(sequence).replaceAll("");
    val code_length: int = sequence.length;

    // Perform regexp counts
    for (val i <- VARIANTS)
    {
      var count: int = 0;
      val m: Matcher = Pattern.compile("(?i)" + i).matcher(sequence);
      while (m.find()) count = count + 1;
      Console.println(i + " " + count);
    }  

    // Perform replacements
    for (val i <- IUBS)
    {
      var iub: Array[String] = i.split(":");
      sequence = Pattern.compile(iub(0)).matcher(sequence).replaceAll(iub(1));
    }

    // Print statistics
    Console.println("\n" + initial_length + "\n" + code_length + "\n" + sequence.length);
  } 

  def loadSequence(): String =
  {
    val buffer: StringBuffer = new StringBuffer();

    var line: String = Console.readLine;

    while (line != null)
    {
      // Needless work, but benchmark mandates sequence contain newlines
      buffer.append(line).append('\n'); line = Console.readLine;
    }

    return buffer.toString();
  }

  val VARIANTS: Array[String] = Array("agggtaaa|tttaccct",
    "[cgt]gggtaaa|tttaccc[acg]", "a[act]ggtaaa|tttacc[agt]t",
    "ag[act]gtaaa|tttac[agt]ct", "agg[act]taaa|ttta[agt]cct",
    "aggg[acg]aaa|ttt[cgt]ccct", "agggt[cgt]aa|tt[acg]accct",
    "agggta[cgt]a|t[acg]taccct", "agggtaa[cgt]|[acg]ttaccct");

  val IUBS: Array[String] = Array("B:(c|g|t)", "D:(a|g|t)",
    "H:(a|c|t)", "K:(g|t)", "M:(a|c)", "N:(a|c|g|t)", 
    "R:(a|g)", "S:(c|g)", "V:(a|c|g)", "W:(a|t)", "Y:(c|t)");
}

