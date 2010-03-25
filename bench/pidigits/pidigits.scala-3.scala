/* 
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 * contributed by Rex Kerr
 * based on version by John Nilsson as modified by Geoff Reedy
*/

object pidigits {
  type I = BigInt
  import BigInt._
    
  class LFT(q:I, r:I, t:I) {
    def compose(k: Int) = new LFT(q*k, (q*(4*k+2))+(r*(2*k+1)), t*(2*k+1))
    def extract = {
      val (y,rem) = (q*3 + r) /% t
      if((rem + q) < t) Some(y.intValue) else None
    }
    def next(y: Int) = new LFT(q*10, (r-(t*y))*10, t)
  }

  def pi_digits = {
    def digits(z: LFT, k: Int): Stream[Int] = z extract match {
      case Some(y) => Stream.cons(y,digits(z next y,k))
      case None    => digits(z compose k,k+1)
    }
    digits(new LFT(1,0,1),1)
  }

  def by[T](s: Stream[T], n: Int): Stream[Stream[T]] =
    if (s.isEmpty) Stream.empty
    else Stream.cons(s take n, by(s drop n, n))

  def main(args: Array[String]): Unit =
    for ((d,n) <- by(pi_digits take args(0).toInt, 10).zipWithIndex)
      printf("%-10s\t:%d\n",d.mkString,10*n+d.length)
}
