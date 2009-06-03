/*
   The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
   contributed by Paul Phillips (directly ported from the Java version)
 */

import java.io.{ BufferedReader, InputStreamReader }
import java.util.concurrent.CyclicBarrier
import java.util.concurrent.atomic.AtomicIntegerArray
import java.util.regex.Pattern
import scala.collection.mutable.ArrayBuffer

object regexdna
{
  lazy val processors = Runtime.getRuntime().availableProcessors
  // source data is duplicated into 2 arrays
  val source_as_segments = new ArrayBuffer[StringBuilder]
  val source_as_lines = new ArrayBuffer[StringBuilder]
  
  def runPool(f: () => Thread) {
    val pool = Array.range(0, processors) map (_ => f())
    pool foreach (_.start)
    pool foreach (_.join)
  }
  
  // read data from stdin to StringBuilder
  // return initial data size
  private def ReadInput(sb: StringBuilder): Int = {
    val reader = new BufferedReader (new InputStreamReader (System.in, "US-ASCII"))
    val buf = new Array[Char](64 * 1024)
    var read, total = 0
    
    while (true) {
      read = reader read buf
      if (read == -1)
        return total
      
      total += read
      sb.append(buf, 0, read)
    }
    0
  }

  // strip header and newline
  // duplicate each data line into 2 arrays
  private def StripHeader(sb: StringBuilder): Int = {
    val pat = Pattern.compile("(>.*\n)|\n")
    val mt = pat matcher sb
    var desti: StringBuilder = null
    val tmp = new StringBuffer()
    
    while (mt.find()) {
      mt.appendReplacement(tmp, "")
      if (mt.start(1) >= 0) {
        desti = new StringBuilder
        source_as_segments += desti
      }
      desti append tmp
      source_as_lines += new StringBuilder(tmp.toString())
      tmp setLength 0
    }
    source_as_segments map (_.length) reduceLeft (_ + _)
  }
  
  private def CountMatch() {
    val patterns = Array(
      "agggtaaa|tttaccct" ,
      "[cgt]gggtaaa|tttaccc[acg]",
      "a[act]ggtaaa|tttacc[agt]t",
      "ag[act]gtaaa|tttac[agt]ct",
      "agg[act]taaa|ttta[agt]cct",
      "aggg[acg]aaa|ttt[cgt]ccct",
      "agggt[cgt]aa|tt[acg]accct",
      "agggta[cgt]a|t[acg]taccct",
      "agggtaa[cgt]|[acg]ttaccct"
    )
    val patCount = patterns.length
    val results = new AtomicIntegerArray(patCount)
    val tasks = new AtomicIntegerArray(patCount)
  
    class RegexDnaCount extends Thread {
      override def run() {
        for (pt <- 0 until patCount) {
          val expression = Pattern compile patterns(pt)
          val total_seg = source_as_segments.size
          val mt = expression.matcher("")

          def doSeq(): Boolean = {
            val seq = tasks getAndIncrement pt
            if (seq >= total_seg)
              return false
            
            mt reset source_as_segments(seq)
            while (mt.find())
              results incrementAndGet pt
            
            true
          }
          
          while (doSeq()) { }
        }
      }
    }
    
    runPool(() => new RegexDnaCount)
    for ((p, i) <- patterns.zipWithIndex)
      println("%s %s".format(p, results get i))
  }

  private val pat_search: Array[String] = 
    "WYKMSRBDVHN".toArray map (c => new String(Array(c)))
    
  private val pat_replace = Array(
    "(a|t)", "(c|t)", "(g|t)", "(a|c)",
    "(c|g)", "(a|g)", "(c|g|t)", "(a|g|t)",
    "(a|c|g)", "(a|c|t)", "(a|c|g|t)"
  )
  private val searchCount = pat_search.length
  
  private def Replace(): Int = {
    val tasks = new AtomicIntegerArray(searchCount)
    val result = new AtomicIntegerArray(searchCount)
    val barrier = new CyclicBarrier(processors)
    
    class RegexDnaReplace extends Thread {
      override def run() {
        val des_buf = new StringBuffer

        for (pt <- 0 until searchCount) {
          val pattern = Pattern compile pat_search(pt)
          val m = pattern.matcher("");
          val total_line = source_as_lines.size
          
          def doLine(): Boolean = {
            val line = tasks.getAndIncrement(pt)
            if (line >= total_line)
              return false
            
            val src_buf = source_as_lines(line)
            m reset src_buf
            var change = false
            
            while (m.find()) {
              m.appendReplacement(des_buf, pat_replace(pt))
              change = true
            }
            
            if (change) {
              m appendTail des_buf
              src_buf setLength 0
              src_buf append des_buf
            }
            
            if (pt == searchCount - 1)
              result.addAndGet(pt, src_buf.length)

            des_buf setLength 0
            true
          }
          while (doLine()) { }
        }
        
        barrier.await
      }
    }
    
    runPool(() => new RegexDnaReplace)    
    0 until searchCount map result.get reduceLeft(_ + _)
  }
  
  def main(args: Array[String]) {
    var sb = new StringBuilder
    val init_len = ReadInput(sb)
    val strip_len = StripHeader(sb)
    sb = null
    
    CountMatch()
    source_as_segments.clear()
    val replace_len = Replace()
    source_as_lines.clear()
    
    println("\n%d\n%d\n%d".format(init_len, strip_len, replace_len))
  }
}
