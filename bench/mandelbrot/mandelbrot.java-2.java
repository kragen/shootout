/* The Computer Language Shootout 
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy

   transliteration of Nice program
*/

import java.io.*;

class mandelbrot {
   public static void main(String[] args) throws java.io.IOException {
      int width = Integer.parseInt(args[0]);   
      int height = width; 
      System.out.println("P4\n" + width + " " + height);

      BufferedOutputStream s = new BufferedOutputStream(System.out);
      double limitSquared = 4.0;
      double iterations = 50;
      boolean isOverLimit = false;
      int bits = 0; int bitnum = 0; 

      for(int y=0; y<height; y++){
         for(int x=0; x<width; x++){

            double Zr = 0.0; double Zi = 0.0;
            double Cr = (2.0*x/width - 1.5); double Ci = (2.0*y/height - 1.0);

            int i = 0;
            do {
               double Tr = Zr*Zr - Zi*Zi + Cr;
               double Ti = 2.0*Zr*Zi + Ci;
               Zr = Tr; Zi = Ti;
               isOverLimit = Zr*Zr + Zi*Zi > limitSquared;
            } while (!isOverLimit && (++i < iterations));

            bits = bits << 1;
            if (!isOverLimit) bits++;
            bitnum++;

            if (x == width - 1) {
               bits = bits << (8 - bitnum);
               bitnum = 8;
            }

            if (bitnum == 8){
               s.write((byte)bits);
               bits = 0; bitnum = 0;
            }
         }
      } 
      s.close();
   }
}

