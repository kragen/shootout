/*
   The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
   Based partially on the single-threaded version by Isaac Gouy with fixes from
   Iulian Dragos and Meiko Rachimow.
   Based on Scala contribution of Rex Kerr
   Based on bit encoding idea of C++ contribution of Andrew Moon
   Contributed by The Anh Tran
   Updated for 2.8 by Rex Kerr
*/

import scala.actors.Futures.future
import scala.actors.Future
import scala.collection.mutable.HashMap
import java.io._

final
object knucleotide
{
   def main(args : Array[String]) =
   {
      // read all data from inputstream
      val data = Helper.readAll

      // hand out tasks, each task will be picked up by scala threadpool
      val tables = List(1, 2, 3, 4, 6, 12, 18)
         .map( sz => queueBuildHashtable(data, sz) )
         .splitAt(2)

      // print frequency of each nucleotide
      tables._1.foreach(printFreq(_, data.length))

      // print how many times a specific pattern appears in input data
      val codeSeq = List("GGT", "GGTA", "GGTATT", "GGTATTTTAATT", "GGTATTTTAATTTATAGT");
      (tables._2 zip codeSeq).foreach( e => printFreq(e._1, e._2) )
   }

   private
   def printFreq(lht: List[Future[KnuHashMap]], data_length : Int) =
   {
      // have to merge (whole list of results) into a hashmap
      val ht = mergeTables(lht)

      // sort by decending frequencies
      val sorted_list = ht.toArray.sortWith((a, b) => !(a._2 < b._2) )

      val total = data_length.toFloat

      sorted_list foreach ( a =>   printf("%s %.3f\n",
                              a._1.decode,
                              (a._2.toFloat * 100.0f / total))   )

      println
   }

   private
   def printFreq(lht : List[Future[KnuHashMap]], pt : String) =
   {
      val ht = mergeTables(lht)

      val k = new KnuKey(pt.length)
      k.encode(pt.toCharArray, 0)
      assert(pt == k.decode)

      val v = ht.getOrElse(k, 0)
      printf("%d\t%s\n", v, pt)
   }

   private
   def queueBuildHashtable(data : Array[Char], frameSize : Int) =
   {
      // each task will hash whole input data, at a specific offset
      // with (0 <= offset < frameSize)
      (0 until frameSize)
         .map( offset => future(buildHashtable(data, frameSize, offset)) )
         .toList
   }

   private
   def buildHashtable(data : Array[Char], frameSize : Int, startOffset : Int) : KnuHashMap =
   {
      val ht = new KnuHashMap
      val key = new KnuKey(frameSize)

      val i_end = data.length - frameSize + 1
      var i_beg = startOffset

      while (i_beg < i_end)
      {
         key.encode(data, i_beg)
         ht.incCounter(key)

         i_beg += frameSize
      }

      ht
   }

   private
   def mergeTables(list_hashtable: List[Future[KnuHashMap]]) =
      list_hashtable
         .map( _() )
         .reduceLeft( (t1, t2) => {
            t2.foreach(e => t1.addCounter(e._1, e._2))
            t1
         })
}

private final
class KnuKey(var key : Long, val hash_length : Int)
{
   def this(hlen: Int) = this(0, hlen)

   @inline
   override def clone() = new KnuKey(key, hash_length)

   @inline
   override def hashCode() : Int = key.toInt

   @inline
   override def equals(other : Any) = other match {
      case that: KnuKey => this.key == that.key
      case _            => false
   }

   @inline
   def encode(data : Array[Char], offset : Int) = {
      var mkey = 0L
      var index = 0
      var shift = 0

      while (index < hash_length)
      {
         mkey |= (Helper(data(offset + index)) << shift)

         shift += Helper.bit_per_code
         index += 1
      }

      key = mkey
      this
   }

   def decode() = {
      val sb = new StringBuilder(hash_length)

      var index = 0
      var extract_mask = Helper.bit_mask

      while (index < hash_length)
      {
         val extract_value = ((key & extract_mask) >>> (index * Helper.bit_per_code)).toInt
         sb append( Helper(extract_value) )

         extract_mask <<= Helper.bit_per_code
         index += 1
      }

      sb toString
   }
}


private final
object Helper {
   val bit_mask      = 3L
   val bit_per_code   = 2

   @inline
   def apply(c : Char) : Long = (c: @annotation.switch) match {
      case 'a'   => 0
      case 't'   => 1
      case 'c'   => 2
      case 'g'   => 3

      case 'A'   => 0
      case 'T'   => 1
      case 'C'   => 2
      case 'G'   => 3

      case _      => assert(false); -1
   }

   private
   val Int2Iub = Array('A', 'T', 'C', 'G')

   @inline
   def apply(c : Int) : Char = Int2Iub(c)


   def readAll() = {
      val reader = new BufferedReader(new InputStreamReader (System.in, "US-ASCII"), 4*1024*1024)

      var line = reader readLine()
      while ((line != null) && ((line(0) != '>') || (line.startsWith(">THREE") == false)))
         line = reader readLine

      val sb = new StringBuilder(32*1024*1024)

      line = reader readLine()
      while (line != null)
      {
         sb append line
         line = reader readLine
      }

      // Read a char by "String.charAt(index)" is much slower than "Array(index)"
      // => use Array[Char]
      sb.toString.toCharArray
   }
}


private final
class KnuHashMap extends HashMap[KnuKey, Int]
{
   @inline
   def incCounter(key : KnuKey) : Unit = addCounter(key, 1)

   @inline
   def addCounter(key : KnuKey, valToAdd: Int) {
      // directly look up entry inside hashtable
      var e  = table(index(key.hashCode)).asInstanceOf[Entry]
      while (e != null)
      {
         if (e.key == key)
         {
            e.value += valToAdd
            return
         }
         else
            e = e.next
      }

      addEntry(new Entry(key.clone, valToAdd))
   }
}
