/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/

   contributed by Jason Nordwick
*/

import java.io.FileDescriptor;
import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

final class ByteWrapper implements CharSequence {

   public byte[] backing;
   public int length;

   public ByteWrapper( byte[] backing ) {
      this( backing, backing.length );
   }
   
   public ByteWrapper( byte[] backing, int length ) {
      this.backing = backing;
      this.length = length;
   }

   public int length() {
      return length;
   }

   public char charAt(int index) {
      return (char) backing[index];
   }
   
   public CharSequence subSequence(int start, int end) {
      throw new UnsupportedOperationException();
   }
}


public final class regexdna {
   
   private static Pattern comments = Pattern.compile(">.*\n|\n");
   
   private static String[][] codes =
      {{"B", "(c|g|t)"},
      {"D", "(a|g|t)"},
      {"H", "(a|c|t)"},
      {"K", "(g|t)"},
      {"M", "(a|c)"},
      {"N", "(a|c|g|t)"},
      {"R", "(a|g)"},
      {"S", "(c|g)"},
      {"V", "(a|c|g)"},
      {"W", "(a|t)"},
      {"Y", "(c|t)"} };
   
   private static Pattern codesPat = Pattern.compile("[BDHKMNRSVWY]");
   
   private static final int longest;
   private static byte[] repl;
 
   private static String[] strs = {
      "agggtaaa|tttaccct",
      "[cgt]gggtaaa|tttaccc[acg]",
      "a[act]ggtaaa|tttacc[agt]t",
      "ag[act]gtaaa|tttac[agt]ct",
      "agg[act]taaa|ttta[agt]cct",
      "aggg[acg]aaa|ttt[cgt]ccct",
      "agggt[cgt]aa|tt[acg]accct",
      "agggta[cgt]a|t[acg]taccct",
      "agggtaa[cgt]|[acg]ttaccct"
   };

   private static Pattern[] pats = new Pattern[strs.length];
   
   static {
      for( int i = 0; i < pats.length; ++i )
         pats[i] = Pattern.compile( strs[i] );
      
      int l = 0;
      for( int i = 0; i < codes.length; ++i )
         l = Math.max( l, codes[i][1].length() );
      longest = l;
      
      repl = new byte[26 * longest + 1];
      for( int i = 0; i < codes.length; ++i ) {
         int off = longest * (codes[i][0].charAt( 0 ) - 'A');
         String code = codes[i][1];
         for( int j = 0; j < code.length(); ++j )
            repl[off + j] = (byte) code.charAt( j );
      }
   }
   
   private static void rmComments( ByteWrapper t ) {

      byte[] backing = t.backing;
      Matcher m = comments.matcher( t );
      
      if( !m.find() )
         return;
      
      int tail = m.start();
      int restart = m.end();
            
      while( m.find() ) {
         while( restart != m.start() )
            backing[tail++] = backing[restart++];
         restart = m.end();
      }
      
      while( restart < backing.length )
         backing[tail++] = backing[restart++];
      
      t.length = tail;
   }
   
   private static void countPatterns( ByteWrapper t ) {
            
      for( int i = 0; i < pats.length; ++i ) {
         int c = 0;
         Matcher m = pats[i].matcher( t );
         while( m.find() )
            ++c;
         System.out.println( strs[i] + ' ' + c );
      }
   }
   
   private static ByteWrapper replace( ByteWrapper t ) {
      
      byte[] backing = t.backing;
      byte[] buf = new byte[t.length * longest];
      int pos = 0;
      
      Matcher m = codesPat.matcher( t );
      int last = 0;
      
      while( m.find() ) {
         for( ; last < m.start(); ++last )
            buf[pos++] = backing[last];
         for( int i = longest * (backing[last] - 'A'); repl[i] != 0; ++i )
            buf[pos++] = repl[i];
         ++last;
      }
      
      for( ; last < t.length; ++last )
         buf[pos++] = backing[last];
      
      return new ByteWrapper( buf, pos );
   }

   public static void main( String[] args ) throws Exception {

      FileInputStream fis = new FileInputStream( FileDescriptor.in );
      FileChannel cin = fis.getChannel();
      ByteBuffer bb = ByteBuffer.allocate( (int) cin.size() );
      cin.read( bb );
      
      ByteWrapper t = new ByteWrapper( bb.array() );
      rmComments( t );

      countPatterns( t );
      
      ByteWrapper w = replace( t );
      
      System.out.println();
      System.out.println( t.backing.length );
      System.out.println( t.length() );
      System.out.println( w.length() );
   }

}
