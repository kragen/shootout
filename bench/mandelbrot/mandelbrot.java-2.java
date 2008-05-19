/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/

   contributed by Stefan Krause
   modified by Oleg Estekhin
*/

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;

public class mandelbrot {

    public static void main(String[] args) throws IOException {
        final int n = Integer.parseInt(args[0]);
        System.out.print("P4\n" + n + ' ' + n + '\n');

        final OutputStream out = new BufferedOutputStream(System.out);

        final double step = 2.0 / n;
        int data = 0;

        for (int y = 0; y < n; y++) {
            final double dy0 = step * y - 1.0;
            int x = 0;
            while (x < n) {
                for (int bit = 0; bit < 8; bit++, x++) {
                    final double dx0 = step * x - 1.5;
                    int i = 50;
                    double dx = dx0;
                    double dy = dy0;
                    while (dx * dx + dy * dy <= 4.0 && i > 0) {
                        final double dxtemp = dx * dx - dy * dy + dx0;
                        dy = 2.0 * dx * dy + dy0;
                        dx = dxtemp;
                        i--;
                    }
                    data <<= 1;
                    if (i == 0) {
                        data++;
                    }
                }
                out.write(data);
            }
        }
        out.flush();
    }

}