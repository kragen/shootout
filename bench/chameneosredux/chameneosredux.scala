/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/

   Contributed by Vincent Kraeutler
*/

import scala.actors.Actor
import scala.actors.Actor._
import scala.actors.Exit

object chameneosredux {

    case object Color extends Enumeration {  val Blue, Red, Yellow = Value }
 
    // the input sets of creatures defined by the benchmark
    val firstCreatures = List(Color.Blue, Color.Red, Color.Yellow)
    val secondCreatures = List(Color.Blue, Color.Red, Color.Yellow, Color.Red, 
            Color.Yellow, Color.Blue, Color.Red, Color.Yellow, Color.Red, Color.Blue)
    
    def complement(a: Color.Value, b: Color.Value) : Color.Value = {
        // the complement of two identical colors is defined to be that color
        if (a == b) a
        else if (a > b) complement(b, a)
        else {
            Pair(a, b) match {
                case Pair(Color.Blue, Color.Red) => Color.Yellow
                case Pair(Color.Blue, Color.Yellow) => Color.Red
                case Pair(Color.Red, Color.Yellow) => Color.Blue
                }
        }
    }
    
    def creature(id : int, initialColor : Color.Value, meetingPlace : Actor) = actor {
        
        self.trapExit = true    
        self.link(meetingPlace)
        
        def compareIds(ido: int) : int = { if (id == ido) 1 else 0 } 
        
        def visit(color : Color.Value, nMeetings : int, nMetSelf : int) {
            
            // go for a visit
            meetingPlace ! Triple(self, color, id)
                    
            // then handle the response
            react {
                case Pair(c : Color.Value, ido : int) => {
                    visit(c, nMeetings + 1, nMetSelf + compareIds(ido))
                }
                case Exit(a, b) => { 
                    // meeting place has exited, report final status
                    exit(Pair(nMeetings, nMetSelf))
                }
            }
        }
        
        visit(initialColor, 0, 0)
    }

    
    def meetingPlace(nMaxMatch : int) = actor {

        type Visit = Triple[Actor, Color.Value, int]      
        
        def makeMatch(first : Visit, second : Visit) {
            val cc = complement(first._2, second._2)
            first._1 ! Pair(cc, second._3)
            second._1 ! Pair(cc, first._3)
        }       
        
        def waitForTwoCreatures(n : int) {
            react {  
                case (first : Visit) => {
                    react {
                        case (second : Visit) => {
                            makeMatch(first, second)
                            if (0 == n - 1) exit
                            else waitForTwoCreatures(n - 1)
                            }}}}}
        
        waitForTwoCreatures(nMaxMatch)         
    }

    def chameneosredux(nMeetings : int) = actor {
        
        self.trapExit = true

        def spellNumber(n : int) : String = {
            val numbers = Array("zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine")
            
            def spellDigits(m : int) : String = {
                if (m < 10) {
                    numbers(m % 10)
                } else {
                    spellDigits(m / 10) + " " + numbers(m % 10)
                }
            }
            
            spellDigits(n)
        }
        
        def collect(nCreatures : int, total : int) : String = {            
            if (0 == nCreatures) spellNumber(total)
            else {
                receive { // wait for all creatures to exit
                    case Exit(a, Pair(n : int, m : int)) => {
                        println(n + " " + spellNumber(m))
                        collect(nCreatures - 1, total + n)
                    }}}}

        def go(maxMeetings : int) {          
            val s = meetingPlace(maxMeetings)            
                    
            def launch(colors : List[Color.Value]) {
                println ((colors map showColor) mkString(" ", " ", ""))
                for { (color, id) <- colors.zipWithIndex } yield {
                    self.link(creature(id, color, s))
                    }}
            
            receive {
                case colors : List[Color.Value] => {
                    launch(colors)
                    println(" " + collect(colors.length, 0))
                    println("")
                    sender ! 0
                }}}
        
        go(nMeetings)
    }    

    
    def showColor(c : Color.Value) = {
        c match {
            case Color.Red => "red"
            case Color.Yellow => "yellow"
            case Color.Blue => "blue"
    }}
    
    def showComplements() {
 
        def showComplement(a : Color.Value, b : Color.Value) {
            println(showColor(a)  + " + "  + showColor(b) + " -> " + showColor(complement(a, b)))
        }
        
        Color.elements.foreach{ a =>
            Color.elements.foreach{ b =>
                showComplement(a, b) }}

        println("")
    }
    
    def main(args : Array[String]) : Unit = {
        showComplements
        val nMeetings = Integer.parseInt(args(0))
        chameneosredux(nMeetings) !? firstCreatures
        chameneosredux(nMeetings) !? secondCreatures
    }
}
