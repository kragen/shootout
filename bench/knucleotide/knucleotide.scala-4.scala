/* 
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 * contributed by Rex Kerr
 * (based partially on the single-threaded version by Isaac Gouy
 * with fixes from Iulian Dragos and Meiko Rachimow)
 */

import java.io._
import scala.collection.mutable._
import scala.actors._
import Actor.loop

object knucleotide {
  class ShiftScan(offset:Int, stride:Int) extends Actor {
    val bag = new HashBag
    def findFreq(s:String, j:Int) = {
      val n = s.length - j + 1
      var i = offset
      while (i < n) {
        bag(s.substring(i,i+j)).inc
        i += j
      }
      bag
    }
    def act() { loop { react {
      case seq : String =>
        sender ! findFreq(seq,stride)
        exit
    }}}
  }

  class SizeScan(length:Int, boss:Actor) extends Actor {
    var bags = List[HashBag]()
    val workers = (0 until length).map(new ShiftScan(_,length))
    def act() { loop { react {
      case b : HashBag =>
        bags = b :: bags
        if (bags.length==workers.length) {
          boss ! (bags.head /: bags.tail)(_ ++ _)
          exit
        }
      case seq : String =>
        workers.foreach(_.start ! seq)
    }}}
  }

  class Scan(work : String*) extends Actor {
    val lengths = work.map(_.length)
    val freqs = work.filter(_(0)=='*').map(_.length)
    val counts = work.filter(_(0)!='*')
    val scans = new HashMap[Int,HashBag]()
    var seq_len = 0
     
    def writeFreqs(j : Int) {
      val n  = 1.0 + seq_len - j
      val sorted = scans(j).elements.toList.sort(
        (a,b) => (a.value>b.value) || (a.value==b.value && a.key > b.key)
      )
      sorted.foreach(a => printf(a.key + " %.3f\n", a.value * 100.0 / n))
      println
    }
     
    def act() { loop { react {
      case seq : String =>
        seq_len = seq.length
        lengths.foreach(l => new SizeScan(l,this).start() ! seq)
      case h : HashBag =>
        val n = h.elements.next.key.length
        scans(n) = h
        if (lengths.forall(scans contains _)) {
          freqs.foreach(writeFreqs(_))
          counts.foreach(s => println(scans(s.length)(s).value + "\t" + s))
          exit
        }
    }}}
  }

  def readSequence(id: String, r: BufferedReader) = {
    val b = new java.lang.StringBuilder()
     
    var line = r.readLine
    while (line != null) {
      if (line(0)=='>' && line.startsWith(id)) line = null
      else line = r.readLine
    }
     
    line = r.readLine
    while (line != null) {
      if (line(0)=='>') line = null
      else {
        b.append(line.toUpperCase)
        line = r.readLine
      }
    }
    b.toString
  }
  
  def main(args: Array[String]) {
    val r = new BufferedReader(new InputStreamReader(System.in))
    val seq = readSequence(">THREE",r)
    r.close
      
    val scanner = new Scan("*","**","GGT","GGTA","GGTATT",
                           "GGTATTTTAATT","GGTATTTTAATTTATAGT")
    scanner.start() ! seq
  }
}

class HashBag extends HashTable[String] {
  class Counter(val key: String, var value: Int)
        extends HashEntry[String,Counter]
  {
    def inc { value += 1 }
    def +=(i:Int) { value += i }
  }

  protected type Entry = Counter
  protected def entryKey(e: Entry) = e.key
  def elements = entries
   
  def apply(key:String): Counter = {
    var bucket = table(index(elemHashCode(key))).asInstanceOf[Entry]
    while (bucket ne null) {
      if (elemEquals(entryKey(bucket),key)) return bucket
      bucket = bucket.next
    }
    bucket = new Entry(key,0)
    addEntry(bucket)
    bucket
  }
     
  def ++(h : HashBag) : HashBag = {
    h.elements.foreach(kv => this(kv.key) += kv.value)
    this
  }
}
