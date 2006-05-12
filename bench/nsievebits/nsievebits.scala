/* ------------------------------------------------------------------ */
/* The Great Computer Language Shootout                               */
/* http://shootout.alioth.debian.org/                                 */
/*                                                                    */
/* Reimplementation of 'nsieve.scala' using 'BitSet' type in place of */
/* 'Array' type.                                                      */
/*                                                                    */
/* Contributed by Anthony Borla                                       */
/* ------------------------------------------------------------------ */

import scala.collection.mutable.BitSet;

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
    val sieve: BitSet = new BitSet(m); sieve.ensureCapacity(m);
    
    var i:int = 0; while (i < m) { sieve += i; i = i + 1; }

    var count: int = 0; i = 2; 

    while (i < m)
    {
      if (sieve.contains(i))
      {
        var j: int = i + i; while (j < m) { sieve -= j; j = j + i; }
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

