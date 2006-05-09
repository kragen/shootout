/* ------------------------------------------------------------------ */
/* The Great Computer Language Shootout                               */
/* http://shootout.alioth.debian.org/                                 */
/*                                                                    */
/* Originally reimplemented 'nsieve.scala' using the 'BitSet' type in */
/* place of 'Array' type, but problems encountered i.e. 'BitSet' type */
/* not recognised [this despite it appearing in the Scala doco, though*/
/* I could well have misread this document]. So, have temporarily     */
/* reused 'Array' type to mimic a bit set via bit manipulations, but  */
/* have left old code in comments for easy reference.                 */
/*                                                                    */
/* Contributed by Anthony Borla                                       */
/* ------------------------------------------------------------------ */

object nsievebits
{
  def main(args: Array[String]): unit =
  {
    val N = Integer.parseInt(args(0)); var M: int = 0;

    M = (1 << N) * 10000;
    Console.printf("Primes up to {0} {1}\n")(padr(M, 8, ' '), padr(nsieve(M), 8, ' '));

    M = (1 << N - 1) * 10000;
    Console.printf("Primes up to {0} {1}\n")(padr(M, 8, ' '), padr(nsieve(M), 8, ' '));

    M = (1 << N - 2) * 10000;
    Console.printf("Primes up to {0} {1}\n")(padr(M, 8, ' '), padr(nsieve(M), 8, ' '));
  } 

  def nsieve(m: int): int =
  {
    //
    // val sieve: BitSet = new BitSet(m); sieve.ensureCapacity(m);
    //
    val size: int = (m + 31) >> 5;
    val sieve: Array[int] = new Array[int](size);
    
    //
    // var i:int = 0; while (i < m) { sieve += i; i = i + 1; }
    //
    var i:int = 0; while (i < size) { sieve(i) = 0xffffffff; i = i + 1; }

    var count: int = 0; i = 2; 

    while (i < m)
    {
      //
      // if (sieve.contains(i))
      //
      if ((sieve(i >> 5) & 1 << (i & 31)) != 0)
      {
        //
        // var j: int = i + i; while (j < m) { sieve -= j; j = j + i; }
        //
        var j: int = i + i; while (j < m) { sieve(j >> 5) = sieve(j >> 5) & ~(1 << (j & 31)); j = j + i; }
        count = count + 1;
      }

      i = i + 1;
    }

    return count;
  }

  def padr(v: Any, padlen: int, padchar: char): String =
  {
    val s: String = "" + v; val reqlen: int = s.length() - padlen;
    return if (reqlen < 0) makeString(Math.abs(reqlen), padchar) + s else s; 
  }

  def makeString(len: int, fillchar: char): String =
  {
    val sb: StringBuffer = new StringBuffer(); var i: int = 0;
    while (i < len) { sb.append(fillchar); i = i + 1; }
    return sb.toString();
  }
}

