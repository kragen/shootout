/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
 
   contributed by Stefan Krause
   slightly modified by Chad Whipkey
   parallelized by Colin D Bennett 2008-10-04
   reduce synchronization cost by The Anh Tran
  */

//package mandelbrot;

import java.io.*;
import java.io.IOException;
import java.util.concurrent.atomic.*;

public final class mandelbrot
{
    public static void main(String[] args) throws Exception
    {
        int size = 200;
        if (args.length >= 1)
            size = Integer.parseInt(args[0]);
        
        System.out.format("P4\n%d %d\n", size, size);
        
        int width_bytes = size /8 +1;
        byte[][] output_data = new byte[size][width_bytes];
        AtomicIntegerArray bytes_per_line = new AtomicIntegerArray(size);
        
        Compute(size, output_data, bytes_per_line);
        
        BufferedOutputStream ostream = new BufferedOutputStream(System.out);
        for (int i = 0; i < size; i++)
            ostream.write(output_data[i], 0, bytes_per_line.get(i));
        ostream.close();
    }
    
    private static final void Compute(final int N, final byte[][] output, final AtomicIntegerArray bytes_per_line)
    {
        final AtomicIntegerArray current_line = new AtomicIntegerArray(N);
        
        final Thread[] pool = new Thread[Runtime.getRuntime().availableProcessors()];
        for (int i = 0; i < pool.length; i++)
        {
            pool[i] = new Thread()
            {
                public void run()
                {
                    double inverse_N = 2.0 / N;
                    
                    for (int y = 0; y < N; y++)
                    {
                        byte[] pdata = output[y];
                        
                        int byte_count = 0;
                        double Civ = (double)y * inverse_N - 1.0;

                        int x;
                        while ((x = current_line.getAndAdd(y, 256)) < N)
                        {
                            int limit = ((x +256) < N) ? x +256 : N;
                            int bit_num = 0;
                            int byte_accumulate = 0;
                        
                            for (; x < limit; x++)
                            {
                                double Crv = (double)x * inverse_N - 1.5;

                                double Zrv = Crv;
                                double Ziv = Civ;

                                double Trv = Crv * Crv;
                                double Tiv = Civ * Civ;

                                int i = 49;
                                do
                                {
                                    Ziv = (Zrv * Ziv) + (Zrv * Ziv) + Civ;
                                    Zrv = Trv - Tiv + Crv;

                                    Trv = Zrv * Zrv;
                                    Tiv = Ziv * Ziv;
                                } while ( ((Trv + Tiv) <= 4.0) && (--i > 0));

                                byte_accumulate <<= 1;
                                if (i == 0)
                                    byte_accumulate++;

                                if (++bit_num == 8)
                                {
                                    pdata[ x >>> 3 ] = (byte)byte_accumulate;
                                    byte_count++;
                                    bit_num = byte_accumulate = 0;
                                }
                            } // end foreach column

                            if (bit_num != 0)
                            {
                                byte_accumulate <<= (8 - (N & 7));
                                pdata[ x >>> 3 ] = (byte)byte_accumulate;
                                byte_count++;
                            }
                        } // end fetch 256 columns
                        
                        bytes_per_line.getAndAdd(y, byte_count);
                    } // end foreach (line)
                } // end void run()
            }; // end inner class definition
            
            pool[i].start();
        }
        
        for (Thread t : pool)
        {
            try
            {
                t.join();
            }
            catch (InterruptedException e)
            {
                e.printStackTrace();
            }
        }
    }
}
