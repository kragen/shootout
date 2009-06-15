/* The Computer Language Benchmarks Game 
   http://shootout.alioth.debian.org/   

   Contributed by John Nilsson 
   Major performance improvement by Geoff Reedy  
*/

object pidigits {
    type I = BigInt
    import BigInt._
    val List(_0,_1,_10) = List[I](0,1,10)
  
    class LFT(val q:I, val r:I, val t:I) {
        def compose(o:LFT) = new LFT(q * o.q, (q * o.r) + (r * o.t), t * o.t)
        def extractDigit = {
            val (y,rem) = (3*q + r) /% t
            if((rem + q) < t) Some(y) else None
        }
        def next(y:I) = new LFT(_10*q, _10*(r-(y*t)), t)
        def reduce = {
            val d = (q>>q.lowestSetBit).gcd(r).gcd(t)
            new LFT(q/d,r/d,t/d)
        }
    }

    def pi_digits = {
        def _lfts = Stream from 1 map { k => new LFT(k, k * 4 + 2, k * 2 + 1) }
        def _pi_digits(z:LFT, lfts:Stream[LFT],n:Int): Stream[(Int,I)] = {
            val _z = if(lfts.head.q % 5000 == 0) z reduce else z
            _z extractDigit match {
                case Some(y) => Stream.cons((n,y),_pi_digits(_z next y, lfts,n+1))
                case None    => _pi_digits(_z compose lfts.head, lfts.tail,n)
            }
        }
        _pi_digits(new LFT(_1,_0,_1),_lfts,1)
    }
  
    def by[T](s: Stream[T], n: Int): Stream[Stream[T]] =
        if(s.isEmpty) Stream.empty
        else Stream.cons(s take n, by(s drop n, n))

    def main(args: Array[String]): Unit =
        for (d <- by(pi_digits take args(0).toInt, 10))
            println("%-10s\t:%d".format(d.map(_._2).mkString(""),d.last._1))
}
