/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/

   contributed by James Durbin 
*/

import java.io.*;
import java.nio.*;


// Disable line buffering. 
// By default, System.out flushes the buffer every time a newline is encountered, 
// which is somewhat expensive in this case.  Here we disable this and use a nice 
// big buffer instead. It makes a few seconds difference, but is obviously 
// quite ugly. 

def disableStdOutLineBuffering(){            
   FileOutputStream fdout = new FileOutputStream(FileDescriptor.out);
   BufferedOutputStream bos = new BufferedOutputStream(fdout,262144);
   PrintStream ps = new PrintStream(bos,false);
   System.setOut(ps);      
}
disableStdOutLineBuffering()


// Define a complement array...  
comp= new char[128];
comp[(byte)'A']=comp[(byte)'a']=(char)'T';
comp[(byte)'C']=comp[(byte)'c']=(char)'G';
comp[(byte)'G']=comp[(byte)'g']=(char)'C';
comp[(byte)'T']=comp[(byte)'t']=(char)'A';
comp[(byte)'V']=comp[(byte)'v']=(char)'B';
comp[(byte)'H']=comp[(byte)'h']=(char)'D';
comp[(byte)'R']=comp[(byte)'r']=(char)'Y';
comp[(byte)'M']=comp[(byte)'m']=(char)'K';
comp[(byte)'Y']=comp[(byte)'y']=(char)'R';
comp[(byte)'K']=comp[(byte)'k']=(char)'M';
comp[(byte)'B']=comp[(byte)'b']=(char)'V';
comp[(byte)'D']=comp[(byte)'d']=(char)'H';
comp[(byte)'U']=comp[(byte)'u']=(char)'A';
comp[(byte)'N']=comp[(byte)'n']=(char)'N';
comp[(byte)'W']=comp[(byte)'w']=(char)'W';
comp[(byte)'S']=comp[(byte)'s']=(char)'S';


def reverseComplement(buf) {
   buf.reverse();      
   int buflen = buf.length();
   for (int i = 0;i < buflen;i++) {
      buf.setCharAt(i,comp[(byte)buf.charAt(i)]);
   }
   return(buf);
}

def writeSeq(buf) {

   int stop = buf.length()/60;
   int lineNum = 0,j=0;
   while (lineNum < stop) {
      System.out.println(buf.subSequence(j,j+60));
      j+=60;
      lineNum++;
   }
   if (j < buf.length()) {
      System.out.println(buf.subSequence(j,buf.length()));
   }
}

      
def buf = new StringBuffer();
def i = 0;
System.in.readLines().each{line->
   if (line.startsWith(">")) {
      buf = reverseComplement(buf);
      writeSeq(buf);
      System.out.println(line);
      buf = new StringBuffer();
   } else {
      buf.append(line);
   }
}
buf = reverseComplement(buf);
writeSeq(buf);
System.out.flush();  // Groovy bug? No auto-flush on exit. 
