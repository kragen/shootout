/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/

   originally written by Jochen Hinrichsen
   fixed for Groovy 1.5 and refactored by Cedric Hurst 
*/

public class fasta {
   static final def NEWLINE = "\n".getBytes()[0]
   
   static final def LINE_LENGTH = 60
   
   // Weighted selection from alphabet
   static final String ALU = "GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG" +
   "GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA" +
   "CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT" +
   "ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA" +
   "GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG" +
   "AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC" +
   "AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA"
   static final byte[] ALUB = ALU.getBytes()
   
   static def frequency(String s, double p) {
      return [p, (byte)s]
   }
   
   static final def IUB = [
           frequency('a', 0.27d),
           frequency('c', 0.12d),
           frequency('g', 0.12d),
           frequency('t', 0.27d),
   
           frequency('B', 0.02d),
           frequency('D', 0.02d),
           frequency('H', 0.02d),
           frequency('K', 0.02d),
           frequency('M', 0.02d),
           frequency('N', 0.02d),
           frequency('R', 0.02d),
           frequency('S', 0.02d),
           frequency('V', 0.02d),
           frequency('W', 0.02d),
           frequency('Y', 0.02d)
   ]
   
   static final def HomoSapiens = [
           frequency('a', 0.3029549426680d),
           frequency('c', 0.1979883004921d),
           frequency('g', 0.1975473066391d),
           frequency('t', 0.3015094502008d)
   ]
   
   static final def BUFFER_SIZE = 8192
   
   // pseudo-random number generator
   static def IM = 139968
   static def IA = 3877
   static def IC = 29573
   static def last = 42
   
   static def random(def max) {
       last = (last * IA + IC) % IM
       max * last / IM
   }
   
   static def makeCumulative(a) {
        def cp = 0.0d
        for (i in 0..<a.size()) {
            cp += a[i][0]
            a[i][0] = cp
        }
   }
   
   // select a random frequency.c
   def selectRandom() {
       def len = a.size()
       def r = random(1.0d)
       for (i in 0..<len)
           if (r < a[i][0])
               return a[i][1]
       return a[len - 1][1]
   }
   
   String id, desc
   int n, index
   PrintStream writer
   byte[] bbuffer
   def a
   
   public fasta()
   {
      this.bbuffer = new byte[BUFFER_SIZE]
      this.index = 0
   }
   
   def makeRepeat() {
      byte[] bbuffer = new byte[BUFFER_SIZE]
      index = 0
      int m = 0
      int k = 0
      int kn = a.length()
      writer << ">" + id + " " + desc + "\n"
      while (n > 0) {
            m = (n < LINE_LENGTH) ? n : LINE_LENGTH
            if (BUFFER_SIZE - index < m){
               writer.write(bbuffer, 0, index)
               index = 0
            }
            for (i in 0..<m) {
               if (k == kn) k = 0
               bbuffer[index++] = ALUB[k++]
            }
            bbuffer[index++] = NEWLINE
            n -= LINE_LENGTH
      }
      if(index != 0) writer.write(bbuffer, 0, index)
   }
   
   def makeRandom() {
      index = 0
      int m = 0
      writer << ">" + id + " " + desc + "\n"
      while (n > 0) {
            m = (n < LINE_LENGTH) ? n : LINE_LENGTH
            if (BUFFER_SIZE - index <= m){
                  writer.write(bbuffer, 0, index)
                  index = 0
            }
            for (i in 0..<m) {
               bbuffer[index++] = selectRandom()
            }
            bbuffer[index++] = NEWLINE
            n -= LINE_LENGTH
      }
      if(index != 0) writer.write(bbuffer, 0, index)
   }
   
   public static void main(args)
   {
      makeCumulative(HomoSapiens)
      makeCumulative(IUB)
      
      def n = !args ? 2500000 : args[0].toInteger()

      new fasta(id: "ONE", desc: "Homo sapiens alu", 
                 a: ALU, n: n * 2, writer: System.out).makeRepeat()

      new fasta(id: "TWO", desc: "IUB ambiguity codes",
                 a: IUB, n: n * 3, writer: System.out).makeRandom()

      new fasta(id: "THREE", desc: "Homo sapiens frequency", 
                 a: HomoSapiens, n: n * 5, writer: System.out).makeRandom()
   }
}
