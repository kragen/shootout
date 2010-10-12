/* The Computer Language Benchmarks Game
http://shootout.alioth.debian.org/
contributed by Kenneth Jonsson
*/

import java.io.BufferedOutputStream;
import java.util.Vector;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class mandelbrot implements Callable<byte[]>
{
    public static final double limitSquared = 4;
    public static final int maxIterations = 50;

    public static int N;
    public static int bytesPerRow;

    private int rowNum;

    public mandelbrot(int rn)
    {
        rowNum = rn;
    }

    public byte[] call()
    {
        // rowBitmap is initialized to all zeros by the JVM.
        byte[] rowBitmap = new byte[bytesPerRow];
        double ci = 2.0 * rowNum / N - 1.0;

        for (int column = 0; column < N; column++)
        {
            double cr = 2.0 * column / N - 1.5;
            double zr = 0;
            double tr = 0;
            double zi = 0;
            double ti = 0;
            int iteration = 0;

            do {
                zi = 2 * zr * zi + ci;
                zr = tr - ti + cr;
                ti = zi * zi;
                tr = zr * zr;
            } while (tr + ti <= limitSquared && ++iteration < maxIterations);

            if (tr + ti <= limitSquared)
                rowBitmap[column >> 3] |= (byte) (0x80 >> (column & 7));
            // else: leave the bit cleared
        }
        return rowBitmap;
    }

    public static void main(String[] args) throws Exception
    {
        N = Integer.parseInt(args[0]);
        bytesPerRow = (N + 7) / 8;

        // Add each row as a future calculation
        Vector<mandelbrot> rows = new Vector<mandelbrot>(N);
        for (int row = 0; row < N; row++)
            rows.add(row, new mandelbrot(row));

        System.out.format("P4\n%d %d\n", N, N);
        BufferedOutputStream ostream = new BufferedOutputStream(System.out);

        // Create an executor backend with one thread per available
        // core in this system
        int numThreads = Runtime.getRuntime().availableProcessors();
        ExecutorService executor = Executors.newFixedThreadPool(numThreads);

        // Submit all the future row calculations to the executor and
        // write the results as they finish.
        for (Future<byte[]> row : executor.invokeAll(rows))
            ostream.write(row.get(), 0, bytesPerRow);
        ostream.close();
        executor.shutdown();
    }
}
