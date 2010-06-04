/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/

   conversion to Scala by Rex Kerr
   from Java version by Oleg Mazurov and Isaac Gouy
*/

object fannkuchredux
{
  def fannkuch(n: Int): Int = {
    val perm1 = Array.range(0,n)
    val perm, count = new Array[Int](n)
    var f, i, k, r, flips, nperm, checksum = 0

    r = n
    while (r>0) {
      i = 0
      while (r != 1) { count(r-1) = r; r -= 1 }
      while (i < n) { perm(i) = perm1(i); i += 1 }
      
      // Count flips and update max  and checksum
      f = 0
      k = perm(0)
      while (k != 0) {
        i = 0
        while (2*i < k) {
          val t = perm(i); perm(i) = perm(k-i); perm(k-i) = t
          i += 1
        }
        k = perm(0)
        f += 1
      }
      if (f>flips) flips = f
      if ((nperm&0x1)==0) checksum += f
      else checksum -= f

      // Use incremental change to generate another permutation
      var go = true
      while (go) {
        if (r == n) {
          println(checksum)
          return flips
        }
        val p0 = perm1(0)
        i = 0
        while (i < r) {
          val j = i+1
          perm1(i) = perm1(j)
          i = j
        }
        perm1(r) = p0

        count(r) -= 1
        if (count(r) > 0) go = false
        else r += 1
      }
      nperm += 1
    }
    flips
  }

  def main(args: Array[String]) {
    val n = (if (args.length > 0) args(0).toInt else 7)
    println("Pfannkuchen("+n+") = "+fannkuch(n))
  }
}
