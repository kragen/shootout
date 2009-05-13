/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
   contributed by Eric Willigers
*/

object revcomp extends java.io.ByteArrayOutputStream with Application {
   val cmp = Array.range(0, 128)
   for ((a, b) <- "TAGCVHRMYKBDU".toList.zip("ATCGBDYKRMVHA".toList)) {
      cmp(a) = b
      cmp(a + 32) = b
   }

   def reverse() {
      if (count > 0) {
         var begin = buf.indexOf('\n') + 1
         var end = count - 1
         while (begin <= end) {
            if (buf(begin) == '\n') begin += 1
            if (buf(end) == '\n') end -= 1
            if (begin <= end) {
               val tmp = buf(begin)
               buf(begin) = cmp(buf(end)).byteValue
               begin += 1
               buf(end) = cmp(tmp).byteValue
               end -= 1
            }
         }
         System.out.write(buf, 0, count)
      }
   }

   val line = new Array[Byte](82)
   var read = System.in.read(line)
   while (read != -1) {
      var i = 0
      var last = 0
      while (i < read) {
         if (line(i) == '>') {
            write(line, last, i - last)
            reverse()
            reset()
            last = i
         }
         i += 1
      }
      write(line, last, read - last)
      read = System.in.read(line)
   }
   reverse()
}
