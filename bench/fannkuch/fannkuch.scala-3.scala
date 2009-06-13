/* The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 * contributed by Rex Kerr
 */

import scala.actors._

object fannkuch {  
  case class Job(start:Array[Int],n:Int)
  case class Found(who:Kucher,k:Int)
  case class Stop()

  class Kucher(val foreman:Fanner,len:Int,num:Int) extends Actor {
    var go = true
    val perm = new Array[Int](len)
    val temp = new Array[Int](len)
    val flip = new Array[Int](len)

    def permute(n:Int) : Boolean = {
      var i = 0
      while (i < n-1 && flip(i)==0) {
        var j = 0
        val t = perm(0)
        while (j<=i) {
          perm(j) = perm(j+1)
          j = j+1
        }
        perm(j) = t
        i = i+1
      }
      flip(i) -= 1;
      while (i>0) {
        i -= 1
        flip(i)=i
      }
      flip(n-1)>=0
    }

    def count() = {
      var K = 0
      var i = 0
      while (i<perm.length) {
        temp(i) = perm(i)
        i += 1
      }
      while (temp(0)!=0) {
        var m = temp(0)
        i = 0
        while (i<m) {
          val t = temp(i)
          temp(i) = temp(m)
          temp(m) = t
          i += 1
          m -= 1
        }
        K += 1
      }
      K
    }

    def act() { Actor.loopWhile(go) { react {
      case x : Job =>
        var K = 0
        var verbose = 30
        var i = 0
        while (i<perm.length) {
          perm(i) = x.start(i)
          if (perm(i) != i) verbose = 0 
          flip(i)=i
          i += 1
        }
        do {
          if (verbose > 0) {
            println( perm.map(_+1).mkString("") )
            verbose -= 1
          }
          K = K max count
        } while (permute(x.n))
        foreman ! Found(this,K)
      case s : Stop =>
        go = false
    }}}
  }
  
  class Fanner(work:Array[Job], workers:Array[Kucher], N:Int) extends Actor {
    var next = 0
    var K = 0
    var done = 0
    def act() { Actor.loop { react {
      case msg : Found =>
        K = K max msg.k
        if (msg.k>=0) done += 1
        if (next < work.length) {
          msg.who ! work(next)
          next += 1
        }
        else if (done==work.length) {
          println("Pfannkuchen(" + N + ") = " + K)
          workers.foreach(_ ! Stop())
          exit()
        }
    }}}
  }
  
  def swapped(a:Array[Int],i:Int,j:Int) = {
    val b  = java.util.Arrays.copyOf(a,a.length)
    b(i) = a(j)
    b(j) = a(i)
    b
  }

  def main(args:Array[String]) {
    val N = args(0).toInt
    val base = (0 until N).toArray

    // Split full problem into subsets for parallelization by swapping
    // Nth entry into i<N spot and then finding permutations of first (N-1)
    // (Do it recursively down to length 8 to help with load balacing.)
    val work = new collection.mutable.ListBuffer[Job]()
    work += Job(base,N min 8)
    for (i <- N-1 to 8 by -1) {
      for (j <- 0 until i) {
        work += Job(swapped(base,i,j) , i)
      }
    }
    // Uncomment this to see which permutations are tested in each work block:
    // work.foreach( w => println("Permute first " + w.n + " of " + w.start.mkString(",")) )

    val workers = new Array[Kucher]( Runtime.getRuntime.availableProcessors );
    val foreman = new Fanner( work.toArray , workers , N );
    foreman.start()
    for (i <- 0 until workers.length) {
      workers(i) = new Kucher(foreman,N,i)
      workers(i).start
      foreman ! Found(workers(i),-1)
    }
  }
}
