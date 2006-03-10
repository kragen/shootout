/* ------------------------------------------------------------------ */
/* The Great Computer Language Shootout                               */
/* http://shootout.alioth.debian.org/                                 */
/*                                                                    */
/* Contributed by Anthony Borla                                       */
/* ------------------------------------------------------------------ */

object revcomp
{
  def main(args: Array[String]): unit =
  {
    var segment: StringBuffer = new StringBuffer();
    var sequence: String = Console.readLine;

    while (sequence != null)
    {
      if (sequence.charAt(0) == '>')
      {
        if (segment.length() != 0) dumpSegment(segment, 60);
        Console.println(sequence);
      }
      else
      {
        segment.append(sequence);
      }

      sequence = Console.readLine;
    }

    dumpSegment(segment, 60);
  }

  def dumpSegment(segment: StringBuffer, splitlength: int): unit =
  {
    splitAndPrint(complement(segment.reverse()), splitlength); segment.setLength(0);
  }

  def complement(segment: StringBuffer): StringBuffer =
  {
    def complement(code: char): char =
    {
      return "TVGH\0\0CD\0\0M\0KN\0\0\0YSAABW\0R\0".charAt(Character.toUpperCase(code) - 'A');
    }

    var i: int = 0; val length: int = segment.length();

    while (i < length)
    {
      segment.setCharAt(i, complement(segment.charAt(i))); i = i + 1;
    }

    return segment;
  }

  def splitAndPrint(segment: StringBuffer, splitlength: int): unit =
  {
    var i: int = 0; var start: int = 0; val length: int = segment.length();

    while (i < length)
    {
      if (i % splitlength == 0 && i > 0)
      {
        Console.println(segment.substring(start, i)); start = i;
      }

      i = i + 1;
    }

    Console.println(segment.substring(start, i));
  }
}

