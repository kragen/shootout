/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
   contributed by Amir K aka Razii
*/

import java.io.*;

public final class sumcol {
   
   static final byte[] buf = new byte [32768];
   static final DataInputStream in = new DataInputStream (System.in);
   static int count = 0;
   static int token = 0;
   static int index = 0;
      
   public static void main(String[] args) throws Exception {
      int sum = 0;
      while (count >= 0){
      	  readToken();
          sum += token; 
      }    	
      System.out.println(sum);
   }
   
   private static void readToken() throws Exception
   {   	    
   	    int c = read();
	    boolean neg = false;
	    if (c == '-') {
	    	neg = true;
	    	c = read();
	    }
	    token = 0;
	    while (true) {
	      if ('0' <= c && c <= '9') {
		  token = token * 10 + (c - '0');
		  } else
		      break;
		  c = read();
	    }
	    token = neg ? -token : token;
	    return;
   }
   private static int read() throws Exception
   {
   	   if (count == 0)
   	   {
   	   	count = in.read(buf); 
   	   	if (count == -1)
   	   	   return '\0';
   	   	index = 0;  
   	   }
   	  count--; 
      return buf [index++];
   }
}
