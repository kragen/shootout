/*   The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/

   Adapted by Antti Lankila from the earlier Isaac Gouy's implementation
   Add multithread & tweaks from C++ by The Anh Tran
*/

using System;
using System.Threading;
using System.IO;

public class MandelBrot
{
    private static int      N = 200;
    private static int      width_bytes;
    
    private static byte[][] data;
   private static int[]    nbyte_each_line;


   public static void Main (String[] args)
   {
      if (args.Length > 0)
         N = Int32.Parse(args[0]);
      Console.Out.WriteLine("P4\n{0} {0}", N);

      width_bytes = N/8;
      if (width_bytes*8 < N)
         width_bytes += 1;

      nbyte_each_line = new int[N];

        data = new byte[N][];
        for (int i = 0; i < N; i++)
            data[i] = new byte[width_bytes];

      Thread[] threads = new Thread[Environment.ProcessorCount];
      for (int i = 0; i < threads.Length; i++)
      {
         threads[i] = new Thread(MandelBrot.Calculate);
            threads[i].Start();
      }

      foreach (Thread t in threads)
         t.Join();

        Stream s = Console.OpenStandardOutput();
      for (int y = 0; y < N; y++)
         s.Write( data[y], 0, nbyte_each_line[y]);
   }


   private static int current_line = -1;

   private static void Calculate()
   {
      double inverse_n = 2.0 / N;

      int y;
      while ((y = Interlocked.Increment(ref current_line)) < N) // fetch a line
      {
            byte[] pdata = data[y];

         int byte_count  = 0;
            int bit_num     = 0;
            int byte_acc    = 0;

            double Civ = y * inverse_n - 1.0;

         for (int x = 0; x < N; x++)
         {
            double Crv = x * inverse_n - 1.5;

            double Zrv   = Crv;
            double Ziv   = Civ;
            double Trv   = Crv * Crv;
            double Tiv   = Civ * Civ;

            int i = 49;
            do
            {
               Ziv = (Zrv*Ziv) + (Zrv*Ziv) + Civ;
               Zrv = Trv - Tiv + Crv;

               Trv = Zrv * Zrv;
               Tiv = Ziv * Ziv;
            }   while ( ((Trv + Tiv) <= 4.0) && (--i > 0) );

            byte_acc <<= 1;
            byte_acc |= (i == 0) ? 1 : 0;

            if (++bit_num == 8)
            {
                    pdata[byte_count] = (byte)byte_acc;
               byte_count++;
               bit_num = byte_acc = 0;
            }
         } // end foreach (column)

         if (bit_num != 0) // write left over bits
         {
            byte_acc <<= (8 - (N & 7));
            pdata[byte_count] = (byte)byte_acc;
            byte_count++;
         }

         nbyte_each_line[y] = byte_count;
      }
   }
};
