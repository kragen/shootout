/*
 * The Computer Language Shootout
 * http://shootout.alioth.debian.org/
 *
 * contributed by David Pollak
 */

import java.io.InputStream

object sumcol
{
  def main(args: Array[String]) =
  {
    def sumIn(cur: int, sum: int, in: InputStream): int = {
      val i = in.read
      if (i == -1) sum
      else {
        val c = i.toChar
        if (c >= '0' && c <='9') sumIn(cur * 10 + (c - '0'), sum, in)
        else sumIn(0, sum + cur, in)
      }
    }

    Console.println(sumIn(0,0, System.in))
  }
}
