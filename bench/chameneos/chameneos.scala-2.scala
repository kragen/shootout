/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
   contributed by Julien Gaugaz
   inspired by the version contributed by Yura Taras and modified by Isaac Gouy
*/
  
import scala.actors.Actor
import scala.actors.Actor._
import scala.actors.Exit

object chameneos {
  
  abstract class Colour
  case object RED extends Colour
  case object YELLOW extends Colour
  case object BLUE extends Colour
  case object FADED extends Colour
  
  val colours = Array(BLUE, RED, YELLOW)
  
  case class Meet(colour:Colour)
  case class Change(colour:Colour)
  case class MeetingCount(count:int)
  
  
  class Mall(var n: int, numChameneos: int) extends Actor {
    var waitingChameneo:Option[Actor] = None
    startChameneos()
    start()
    
    def startChameneos(): Unit = {
      var i = 0
      while(i < numChameneos) {
        Chameneo(this, colours(i%3), i).start()
        i = i + 1
      }
    }
    
    def act() {
      var sumMeetings = 0
      var numFaded = 0
      loop {
        react {
          
          case MeetingCount(i) => {
            numFaded = numFaded + 1
            sumMeetings = sumMeetings + i
            if(numFaded == numChameneos) {
              println(sumMeetings)
              exit()
            }
          }
          
          case msg@Meet(c) => {
            if(n > 0) {
	      waitingChameneo match {
                case Some(chameneo) =>
                  n = n-1
                  chameneo.forward(msg)
                  waitingChameneo = None
                case None =>
                  waitingChameneo = Some(sender)
              }
            } else {
              waitingChameneo match {
                case Some(chameneo) =>
                  chameneo!Exit(this, "normal")
                case None => 
              }
              sender!Exit(this, "normal")
            }
          }
          
        }
      }
    }
  }
  
  case class Chameneo(var mall: Mall, var colour: Colour, id:int) extends Actor {
    var meetings = 0
    def act() {
      loop {
        mall!Meet(colour)	
        react {
          case Meet(otherColour) =>
            colour = complement(otherColour)
            meetings = meetings +1
            sender!Change(colour)
          case Change(newColour) =>
            colour = newColour
            meetings = meetings +1
          case Exit(_,_) =>
	    colour = FADED
            sender!MeetingCount(meetings)
            exit()
        }
      }
    }
    
    def complement(otherColour:Colour): Colour = {
      colour match {
      case RED => otherColour match {
        case RED => RED
        case YELLOW => BLUE
        case BLUE => YELLOW
        case FADED => FADED
      }
      case YELLOW => otherColour match {
        case RED => BLUE
        case YELLOW => YELLOW
        case BLUE => RED
        case FADED => FADED
      }
      case BLUE => otherColour match {
        case RED => YELLOW
        case YELLOW => RED
        case BLUE => BLUE
        case FADED => FADED
      }
      case FADED => FADED
      }
    }
    override def toString() = id+"("+colour+")"
  }
  
  def main(args : Array[String]) : Unit = {
    if(args.length < 1) throw new IllegalArgumentException("Syntax: scala chameneos N [numChameneos]")
    val N = Integer.parseInt(args(0))
    var numChameneos = 4
    if(args.length == 2)
      numChameneos = Integer.parseInt(args(1))
    new Mall(N, numChameneos)
  }
}
