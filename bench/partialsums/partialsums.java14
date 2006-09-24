/* The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Josh Goldfoot
   based on the D version by Dave Fladebo
   modified by Isaac Gouy
*/

import java.text.DecimalFormat;
import java.text.NumberFormat;

public class partialsums {
    
    private static final NumberFormat formatter = new DecimalFormat("#0.000000000");

    public static void main(String[] args) {
        double n = 2500001;
        if (args.length > 0) n = Integer.parseInt(args[0]) + 1;
        double[] sum = new double[9];
        double alt = 1.0;

        for (double d = 1; d < n; d++, alt = -alt) {
            double d2 = d * d;
            double d3 = d2 * d;
            double ds = java.lang.Math.sin(d);
            double dc = java.lang.Math.cos(d);

            sum[0] += java.lang.Math.pow(2 / 3.0,d - 1);
            sum[1] += 1 / java.lang.Math.sqrt(d);
            sum[2] += 1 / (d * (d + 1));
            sum[3] += 1 / (d3 * ds * ds);
            sum[4] += 1 / (d3 * dc * dc);
            sum[5] += 1 / d;
            sum[6] += 1 / (d2);
            sum[7] += alt / d;
            sum[8] += alt / (2 * d - 1);
        }

        String[] names = {"(2/3)^k", "k^-0.5", "1/k(k+1)", "Flint Hills", 
                "Cookson Hills", "Harmonic", "Riemann Zeta", 
                "Alternating Harmonic", "Gregory" };

        for (int i = 0; i < 9; i++)
            System.out.println(formatter.format(sum[i]) + "\t" + names[i]);
        }
    
}
