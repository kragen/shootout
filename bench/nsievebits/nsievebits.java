/* The Computer Language Shootout
http://shootout.alioth.debian.org/

contributed by Alkis Evlogimenos
*/

import java.util.BitSet;

public class nsievebits
{
   private static int nsieve(int m, BitSet bits) {
      bits.set(0, m+1);

      int count = 0;
      for (int i = 2; i <= m; ++i) {
         if (bits.get(i)) {
         for (int j = i + i; j <=m; j += i)
            bits.clear(j);
            ++count;
         }
      }
      return count;
   }

   public static void main(String[] args)
   {
      int n = 2;
      if (args.length > 0)
         n = Integer.parseInt(args[0]);
      if (n < 2)
         n = 2;

      int m = (1 << n) * 10000;
      BitSet bits = new BitSet(m+1);
      System.out.println("Primes up to " + m + " " + nsieve(m, bits));

      m = (1 << n-1) * 10000;
      System.out.println("Primes up to " + m + " " + nsieve(m, bits));

      m = (1 << n-2) * 10000;
      System.out.println("Primes up to " + m + " " + nsieve(m, bits));
   }
}
