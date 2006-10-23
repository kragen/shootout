/* The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy
*/


import scala.concurrent._ 

object message {
   def main(args: Array[String]) = {
      val n = Integer.parseInt(args(0))
      val nActors = 500
      val finalSum = n * nActors

      case class Message(value: Int)

      class Incrementor(next: Actor) extends Actor {
         var sum = 0

         override def run() = {
            while (true) {
               receive { 
                  case Message(value) => 
                     val j = value + 1 
                     if (next != null){ 
                        next.send( Message(j) ) 
                     } else { 
                        sum = sum + j
                        if (sum >= finalSum){ 
                           Console.println(sum); 
                           System.exit(0) // exit without cleaning up
                        }
                     } 
               }
            }
         }

         def istart() = { this.start; this }
      }

      def actorChain(i: Int, a: Actor): Actor = 
         if (i > 0) actorChain(i-1, new Incrementor(a).istart ) else a

      val firstActor = actorChain(nActors, null)
      var i = n; while (i > 0){ firstActor.send( Message(0) ); i = i-1 }
   }
}
