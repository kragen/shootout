/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
   contributed by Yura Taras
   modified by Isaac Gouy
   modified by Julien Gaugaz
*/


object chameneos {
  abstract class Colour
  case object RED extends Colour
  case object YELLOW extends Colour
  case object BLUE extends Colour
  case object FADED extends Colour
  val colours = Array(BLUE, RED, YELLOW)
  class MeetingPlace(var n: int) {
    var other: Creature = _
    def meet(c: Creature) = synchronized {
      if(n > 0) {
          if(other == null) {
            other = c;
            this.wait()
          } else {
            other.setOther(c.colour)
            c.setOther(other.colour)
            other = null
            n = n - 1
            this.notify()
          }
        } else {
          c.setOther(FADED)
      }
    }
  }
  class Creature(private val mp: MeetingPlace, var colour: Colour) extends Thread {
    private var met = 0
    var other: Colour = _
    def setOther(_o: Colour) {
      other = _o
    }
    def getCreaturesMet = met
    override def run() {
      try {
        while(colour != FADED) {
          mp.meet(this)
          if(other == FADED) {
            colour = FADED
          } else {
            met = met + 1
            colour = complement(other)
          }
        }
      } catch {
        case e:InterruptedException => () // Let the thread exit
      }
    }

    def complement(other: Colour) = Pair(colour,other) match {
          case Pair(RED,YELLOW) => BLUE
          case Pair(RED,BLUE)   => YELLOW
          case Pair(RED,RED)    => RED
          case Pair(YELLOW,BLUE)=> RED
          case Pair(YELLOW,RED)    => BLUE
          case Pair(YELLOW,YELLOW) => YELLOW
          case Pair(BLUE,RED)      => YELLOW
          case Pair(BLUE,YELLOW)   => RED
          case Pair(BLUE,BLUE)     => BLUE
          case Pair(FADED, _)      => FADED
    }
  }

  def apply(n: int, numChameneos: int) {
      val mp = new MeetingPlace(n)
      val creatureColors:Array[Colour] = new Array(numChameneos)
      var i = 0;
      while(i < numChameneos) {
        creatureColors(i) = colours(i%3)
        i = i + 1
      }
      val creatures = for(val x <- creatureColors) yield {
        val cr = new Creature(mp, x);
        cr.start();
        cr
      }
      creatures.foreach(x => x.join)
      val meetings = (creatures foldLeft 0) {(x, y) => (x + y.getCreaturesMet)}
      Console.println(meetings)
  }

  def main(args: Array[String]) {
    if(args.length < 1) throw new IllegalArgumentException("Syntax: scala chameneos N [numChameneos]")
    val N = Integer.parseInt(args(0))
    var numChameneos = 4
    if(args.length == 2)
      numChameneos = Integer.parseInt(args(1))
    chameneos(N, numChameneos)
  }
}



