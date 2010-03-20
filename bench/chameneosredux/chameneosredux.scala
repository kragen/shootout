/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/

   Scala translation contributed by Rex Kerr;
   based on Java original by Michael Barker.
*/


import java.util.concurrent._;
import atomic._;

object chameneosredux {
  object Color extends Enumeration(0,"blue","red","yellow") {
    val Blue,Red,Yellow = Value
    def doComplement(c1: Value, c2: Value) = c1 match {
      case Blue => c2 match {
        case Blue => Blue
        case Red => Yellow
        case Yellow => Red
      }
      case Red => c2 match {
        case Blue => Yellow
        case Red => Red
        case Yellow => Blue
      }
      case Yellow => c2 match {
        case Blue => Red
        case Red => Blue
        case Yellow => Yellow
      }
    }
    def printColors {
      Color.foreach(c1 => Color.foreach(c2 => {
        println(c1 + " + " + c2 + " -> " + doComplement(c1,c2))
      }))
    }
  }

  object Verbalize {
    val digit = Map('0'->"zero",'1'->"one",'2'->"two",'3'->"three",'4'->"four",
                    '5'->"five",'6'->"six",'7'->"seven",'8'->"eight",'9'->"nine")
    def apply(n: Int) = n.toString.toList.map(c=>" "+digit(c)).mkString
  }

  class MeetingPlace(meetings: Int) {
    private val meetingsLeft = new atomic.AtomicInteger(meetings)
    private val creatureRef = new atomic.AtomicReference[Creature]

    def meet(incoming: Creature) {
      val existing = creatureRef.get
      if (existing == null) {
        if (!creatureRef.compareAndSet(existing,incoming)) meet(incoming);
      }
      else {
        val newColor = Color.doComplement(incoming.color,existing.color)      
        if (!creatureRef.compareAndSet(existing,null)) meet(incoming);
        else {
          meetingsLeft.getAndDecrement() match {
            case x if (x>0) =>
              existing.setColor(incoming.id, newColor, x==1);
              incoming.setColor(existing.id, newColor, x==1);
            case _ =>
              existing.finish()
              incoming.finish()
          }
        }
      }
    }
  }

  class Dispatcher(bqc: BlockingQueue[Creature]) extends Runnable {
    def run() {
      try {
        while(true) bqc.take().run()
      }
      catch { case e: InterruptedException => }
    }
  }

  class Creature(place: MeetingPlace, var color: Color.Value, bqc: BlockingQueue[Creature], latch: CountDownLatch) {
    val id = System.identityHashCode(this)
    var count = 0
    private var sameCount = 0

    def finish() { latch.countDown() }
    def setColor(id2: Int, newColor: Color.Value, complete: Boolean) {
      color = newColor
      count += 1
      if (id==id2) sameCount += 1
      if (!complete) bqc.add(this)
      else finish()
    }
    def run() { place.meet(this) }
    override def toString() = count + Verbalize(sameCount)
  }

  def run(n: Int, colors: Color.Value*) {
    val place = new MeetingPlace(n)
    val bqc = new ArrayBlockingQueue[Creature](colors.length)
    val latch = new CountDownLatch(colors.length - 1)

    val creatures = colors.map(c => { print(" "+c) ; new Creature(place, c, bqc, latch) })
    println

    val threads = colors.map(_ => new Thread(new Dispatcher(bqc)))
    threads.foreach(_.start())
    creatures.foreach(c => bqc.add(c))

    try { latch.await }
    catch { case ie: InterruptedException => println("Exiting with error: " + ie) }

    threads.foreach(_.interrupt())

    println( Verbalize ( (0 /: creatures)((sum,c) => { println(c) ; sum + c.count }) ) )
    println
  }

  def main(args: Array[String]) {
    import Color._

    val n = try { args(0).toInt } catch { case _ => 600 }
    
    printColors
    println

    run(n,Blue,Red,Yellow)
    run(n,Blue,Red,Yellow,Red,Yellow,Blue,Red,Yellow,Red,Blue)
  }
}
