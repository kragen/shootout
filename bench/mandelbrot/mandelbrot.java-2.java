/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
   contributed by Stefan Krause
   slightly modified by Chad Whipkey
   parallelized by Colin D Bennett 2008-10-04
*/

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;

public final class mandelbrotmt1 {
    public static void main(String[] args) throws Exception {
        int size = args.length >= 1 ? Integer.parseInt(args[0]) : 1024;
        new mandelbrotmt1(size).compute();
    }

    private final int size;
    private final double fac;
    private final int nThreads;

    public mandelbrotmt1(int size) {
        this.size = size;
        fac = 2.0 / size;
        nThreads = Runtime.getRuntime().availableProcessors();
    }

    public void compute() throws IOException, InterruptedException {
        System.out.format("P4\n%d %d\n", size, size);

        BufferedOutputStream bufOut = new BufferedOutputStream(System.out);
        RowRenderer[] r = new RowRenderer[nThreads];
        for (int i = 0; i < r.length; i++)
            r[i] = new RowRenderer();

        for (int y = 0; y < size;) {
            int n;
            for (n = 0; n < nThreads && y < size; y++, n++) {
                r[n].startComputingRow(y);
            }
            for (int i = 0; i < n; i++) {
                r[i].writeFinishedRow(bufOut);
            }
        }
        bufOut.close();
    }

    private final class RowRenderer implements Runnable {
        private final byte[] workBuf;
        private int row;
        private boolean rowReady;

        public RowRenderer() {
            workBuf = new byte[(size + 7) / 8];    // Length = ceil(size/8)
            rowReady = false;
            row = -1;
            Thread thread = new Thread(this);
            thread.setDaemon(true);
            thread.start();
        }

        public synchronized void run() {
            try {
                while (true) {
                    while (row == -1)
                        wait();
                    computeRow(row);
                    row = -1;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        public synchronized void startComputingRow(int y) throws IOException {
            this.row = y;
            notifyAll();
        }

        private void computeRow(int y) throws IOException {
            int bits = 0;
            int bufIndex = 0;
            int bitMask = 1 << 7;

            final double Ci = (y * fac - 1.0);
            final byte[] buf = this.workBuf;
            for (int x = 0; x < size; x++) {
                double Zr = 0.0;
                double Zi = 0.0;
                double Cr = (x * fac - 1.5);
                int i = 50;
                double ZrN = 0;
                double ZiN = 0;
                do {
                    Zi = 2.0 * Zr * Zi + Ci;
                    Zr = ZrN - ZiN + Cr;
                    ZiN = Zi * Zi;
                    ZrN = Zr * Zr;
                } while (!(ZiN + ZrN > 4.0) && --i > 0);

                if (i == 0)
                    bits |= bitMask;
                bitMask >>>= 1;
                if (bitMask == 0) {
                    buf[bufIndex++] = (byte) bits;
                    bits = 0;
                    bitMask = 1 << 7;
                }
            }

            if (bitMask != 1 << 7) {    // Fraction of a byte left?
                buf[bufIndex++] = (byte) bits;
            }

            assert bufIndex == buf.length
                    : "expected buf to be completely used";
            signalRowReady();
        }

        private synchronized void signalRowReady() {
            rowReady = true;
            notifyAll();
        }

        public synchronized void writeFinishedRow(OutputStream out)
                throws InterruptedException, IOException {
            while (!rowReady)
                wait();
            out.write(workBuf);
            rowReady = false;
        }
    }
}
