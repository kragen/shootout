/* The Great Computer Language Shootout 
   http://shootout.alioth.debian.org/
 
   contributed by Isaac Gouy 
*/

using System;

class NSieve
{
   static int nsieve(int m, bool[] isPrime) {
      for (int i=2; i <= m; i++) isPrime[i] = true;
      int count = 0;

      for (int i=2; i <= m; i++){ 
         if (isPrime[i]){
            for (int k=i+i; k <= m; k+=i) isPrime[k] = false;
            count++;
         }
      }
      return count;
   }

   public static void Main(String[] args) 
   {        
      int n = 2;
      if (args.Length > 0) n = Int32.Parse(args[0]);
      if (n < 2) n = 2;

      int m = (1<<n)*10000; 
      bool[] flags = new bool[m+1];       
      Console.WriteLine("Primes up to {0,8:D} {1,8:D}", m, nsieve(m,flags));

      m = (1<<n-1)*10000;     
      Console.WriteLine("Primes up to {0,8:D} {1,8:D}", m, nsieve(m,flags));

      m = (1<<n-2)*10000;     
      Console.WriteLine("Primes up to {0,8:D} {1,8:D}", m, nsieve(m,flags));
   }
}

/*
  vim: ts=4 ft=cs
 */
 
