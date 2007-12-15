/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/

   Contributed by Vincent Kraeutler
*/
import scala.actors.Actor
import scala.actors.Actor._

object threadring {
        
    class Thread(_label: int) extends Actor {
        
        val label = _label
        var next : Thread = null
                
        def act() { loop { react {
                        case 0 => {
                                println(label)
                                System.exit(0)
                        }
                        case (n: int) => {
                                next ! n - 1
                        }
                }}}  
    }
  
    // create the threads
    var ring = List.range(0, 503).map { i => new Thread(i + 1) }.toArray

    // hook them up
    ring.foreach{t => {
                    val nextIndex = (t.label) % ring.length
                    t.next = ring(nextIndex)
                    t.start
                 }}
            
    def main(args : Array[String]) : Unit = {
           val nHops = Integer.parseInt(args(0))
           ring(0) ! nHops
    }
}
