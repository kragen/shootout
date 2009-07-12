/*   The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
   contributed by Eric Willigers
   based on Java version by The Anh Tran
*/

object spectralnorm {
   val nthread = Runtime.getRuntime.availableProcessors
   val barrier = new java.util.concurrent.CyclicBarrier(nthread)

   def main(args: Array[String]) {
      val n = if (args.length > 0) Integer parseInt args(0)  else 1000
      val fmt = new java.text.DecimalFormat("#.000000000")
      println(fmt format run(n))
   }

   def run(n: Int) = {
      val u = new Array[Double](n)
      val v = new Array[Double](n)
      val tmp = new Array[Double](n)
      val chunk = n / nthread
      var vBv = 0.
      var vv = 0.
      java.util.Arrays.fill(u, 1.)
      Array range(0, nthread) map { i =>
         val rbegin = i * chunk
         val rend = if (i < (nthread -1)) rbegin + chunk else n
         new Approximate(u, v, tmp, rbegin, rend)         
      } foreach { a=>
         a join()
         vBv += a.m_vBv
         vv += a.m_vv
      }
      Math sqrt(vBv/vv)
   }

   final class Approximate(u: Array[Double], v: Array[Double], tmp: Array[Double], rbegin: Int, rend: Int) extends Thread {
      var m_vBv = 0.
      var m_vv = 0.
      start()

      override def run() {
         for (i <- 0 until 10) {
            MultiplyAtAv(u, tmp, v)
            MultiplyAtAv(v, tmp, u)            
         }
         for (i <- rbegin until rend) {
            m_vBv += u(i) * v(i)
            m_vv  += v(i) * v(i)
         }
      }

      @inline
      def eval_A(i: Int, j: Int) = 1.0 / ( ((i+j) * (i+j+1) >>> 1) +i+1 )

      def MultiplyAv(v: Array[Double], Av: Array[Double]) {
         for (i <- rbegin until rend) {
            var sum = 0.
            var j = 0
            while (j < v.length) {
               sum += eval_A(i, j) * v(j)
               j += 1
            }
            Av(i) = sum
         }
      }

      def MultiplyAtv(v: Array[Double], Atv: Array[Double]) {
         for (i <- rbegin until rend) {
            var sum = 0.
            var j = 0
            while (j < v.length) {
               sum += eval_A(j, i) * v(j)
               j += 1
            }
            Atv(i) = sum
         }
      }

      def MultiplyAtAv(v: Array[Double], tmp: Array[Double], AtAv: Array[Double]) {
         MultiplyAv(v, tmp)
         barrier await()
         MultiplyAtv(tmp, AtAv)
         barrier await()
      }
   }
}
