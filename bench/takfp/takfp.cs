/* The Great Computer Language Shootout 
   http://shootout.alioth.debian.org/

   contributed by Isaac Gouy 
*/

using System;

class Takfp
{
   public static float Tak(float x, float y, float z) {
      if (y >= x) return z;
      return Tak(Tak(x-1.0f,y,z), Tak(y-1.0f,z,x), Tak(z-1.0f,x,y)); 
   }

   static void Main(string[] args){
      int n = 1;
      if (args.Length > 0) n = Int32.Parse(args[0]);
      Console.WriteLine("{0}", Tak(n*3.0f, n*2.0f, n*1.0f));
   }
}