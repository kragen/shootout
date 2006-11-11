/* The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy
*/

import java.io._
import scala.collection.mutable.Stack

object revcomp { 

   val IUB = IUBCodeComplements

   def IUBCodeComplements() = {
      val code = "ABCDGHKMNRSTVWYabcdghkmnrstvwy".getBytes
      val comp = "TVGHCDMKNYSABWRTVGHCDMKNYSABWR".getBytes
      val a: Array[byte] = new Array( 'z'.toByte )

      for (val indexValue <- code zip comp)
         indexValue match { case Pair(i,v) => a(i) = v }

      a
   }


   type LineStack = Stack[Array[byte]]

   def main(args: Array[String]) = {
      val r = new FastaInputStream(System.in)
      val w = new BufferedOutputStream(System.out)

      var lines: LineStack = new Stack
      var desc: Array[byte] = null
      val gt = '>'.toByte
      val sc = ';'.toByte

      var line = r.readByteLine
      while (line != null) {
         val c = line(0)
         if (c == gt){ /* '>' */
            if (desc != null){
               complementReverseWrite(desc, lines, w)
               lines = new Stack
            }
            desc = line
         } else {
            if (c != sc /* ';' */) lines += line
         }
         line = r.readByteLine
      }
      r.close

      if (desc != null) complementReverseWrite(desc, lines, w)
      w.close
   } 


   def complementReverseWrite(desc: Array[byte], lines: LineStack, 
         w: BufferedOutputStream) = {

      def inplaceComplementReverse(b: Array[byte]) = {
         var i = 0 
         var j = b.length - 1
         while (i < j){
            val swap = b(i) 
            b(i) = IUB( b(j) ) 
            b(j) = IUB( swap )
            i = i + 1
            j = j - 1
         }
         if (i == j) b(i) = IUB( b(i) )
      }

      val nl = '\n'.toByte
      w.write(desc); w.write(nl)

      val n = 60
      val k = if (lines.isEmpty) 0 else lines.top.length
      val isSplitLine = k < n
      var isFirstLine = true

      while (!lines.isEmpty) {
        val line = lines.pop
        inplaceComplementReverse(line)
        
        if (isSplitLine){
           if (isFirstLine){ w.write(line); isFirstLine = false }
           else { w.write(line,0,n-k); w.write(nl); w.write(line,n-k,k) }
        } 
        else { w.write(line); w.write(nl) }
      }
      if (isSplitLine && !isFirstLine) w.write(nl)
   }

}



class FastaInputStream(in: InputStream) extends BufferedInputStream(in) {

   /**
    * Read a line from a FASTA format file
    *
    * Assume the line is terminated by \n and less than 128 bytes
    *
    * @return The line as Array[byte] or null
    * 
    */

   def readByteLine() = {
      var bytes: Array[byte] = null
      if (in == null) bytes
      else {
         mark(128)                   // mark the start of the line
         if (count == 0) read()      // fill buffer

         val nl = '\n'.toByte   
       
         var i = markpos
         while (i < count && buf(i) != nl) i = i + 1

         if (i >= count){               // line extends past end of buffer
            pos = i; read(); i = pos;   // fill buffer again
            while (i < count && buf(i) != nl) i = i + 1
         }

         if (i < count){     
            bytes = new Array(i - markpos)
            System.arraycopy(buf, markpos, bytes, 0, i - markpos);
            pos = i+1
         }          
      }
      bytes
   }

}
