/* 
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 * contributed by Rex Kerr
 * based on version by John Nilsson as modified by Geoff Reedy
 * GMP wrapping based on Java version by Pall, Kraus, & Sassa
*/

object pidigits {
  import Gmp._
    
  class LFT(q:I, r:I, val t:I) {
    def use(z: LFT) = { ~q; ~r; if (t ne z.t) ~t; z }
    def compose(k: Int) = use(new LFT(q*k!, (q*(4*k+2))+*=(r,(2*k+1))!, t*(2*k+1)!))
    def extract = {
      val (y,rem) = (r + q*3) /% t !!
      val x = if((rem + q) < t) Some(y.toInt) else None
      ~y; ~rem
      x
    }
    def next(y: Int) = use(new LFT(q*10!, (r*10 -*= (t,10*y))!, t))
  }

  def pi_digits = {
    def digits(z: LFT, k: Int): Stream[Int] = z extract match {
      case Some(y) => Stream.cons(y,digits(z next y,k))
      case None    => digits(z compose k,k+1)
    }
    digits(new LFT(I(1),I(0),I(1)),1)
  }

  def by[T](s: Stream[T], n: Int): Stream[Stream[T]] =
    if (s.isEmpty) Stream.empty
    else Stream.cons(s take n, by(s drop n, n))

  def main(args: Array[String]): Unit =
    for ((d,n) <- by(pi_digits take args(0).toInt, 10).zipWithIndex)
      printf("%-10s\t:%d\n",d.mkString,10*n+d.length)
}

/*
 * Partial GMP wrapper for Scala.
 * Write math like normal.
 * Use ! to pull the result off the temporary stack
 * Use ~ to return a value to the temporary stack
 * Be careful with weird +*= GMP functions that destroy argument
*/
class GmpUtil {
  System.loadLibrary("jpargmp")
  @native def mpz_init(): Long
  @native def mpz_clear(src: Long)
  @native def mpz_set_si(lhs: Long, a: Int)
  @native def mpz_get_si(a: Long): Int
  @native def mpz_cmp(a: Long, b: Long): Int
  @native def mpz_add(sum: Long, a: Long, b: Long)
  @native def mpz_sub(sum: Long, a: Long, b: Long)
  @native def mpz_mul_si(prod: Long, a: Long, b: Int)
  @native def mpz_addmul_ui(lhs: Long, a: Long, b: Int)
  @native def mpz_submul_ui(lhs: Long, a: Long, b: Int)
  @native def mpz_tdiv_qr(quot: Long, rem: Long, n: Long, d: Long)
}
object Gmp {
  val gmp = new GmpUtil
  private var stack = Nil:List[I]
  private var defunct = Nil:List[I]
  class I {
    private val z = gmp.mpz_init()
    def !() = stack match {
      case i :: rest if (i eq this) =>
        stack = Nil
        defunct = rest ::: defunct
        i
      case _ => I.die
    }
    def !!() = stack match {
      case i :: j :: rest if (i eq this) =>
        stack = Nil
        defunct = rest ::: defunct
        (i,j)
      case _ => I.die
    }
    def toInt = gmp.mpz_get_si(z)
    def <(i: I) = gmp.mpz_cmp(z, i.z) < 0
    def +(i: I) = { gmp.mpz_add(I.ans.z, z, i.z); I.get }
    def -(i: I) = { gmp.mpz_sub(I.ans.z, z, i.z); I.get }
    def *(n: Int) = { gmp.mpz_mul_si(I.ans.z, z, n); I.get }
    def +*=(i: I, n: Int) = { gmp.mpz_addmul_ui(z, i.z, n); this }
    def -*=(i: I, n: Int) = { gmp.mpz_submul_ui(z, i.z, n); this }
    def /%(i: I) = { val r = I.ans.z; gmp.mpz_tdiv_qr(I.ans.z, r, z, i.z); I.get }
    def unary_~() = { defunct ::= this }
    override def finalize() { gmp.mpz_clear(z); super.finalize }
  }
  object I {
    def apply(n:Int) = defunct match {
      case i :: rest =>
        defunct = rest
        gmp.mpz_set_si(i.z,n)
        i
      case _ =>
        val i = new I
        if (n != 0) gmp.mpz_set_si(i.z,n)
        i
    }
    def ans() = { val i = I(0); stack ::= i; i }
    def die: Nothing = throw new IndexOutOfBoundsException
    def get() = stack match { case i :: rest => i ; case _ => die }
  }  
}
