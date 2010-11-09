/*
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * modified by Enotus
 *
 */

import java.io.*;

public class fasta {

    static final int LINE_LENGTH = 60;
    static final int LOOKUP_SIZE = 4*1024;
    static final double LOOKUP_SCALE = LOOKUP_SIZE - 1;

    static final class Random {
        static final int IM = 139968;
        static final int IA = 3877;
        static final int IC = 29573;
        static final double SCALE = LOOKUP_SCALE / IM;
        static int last = 42;

        static double next() {
            return SCALE * (last = (last * IA + IC) % IM);
        }
    }

    static final class Freq {
        byte c;
        double p;
        Freq(char cc, double pp) {c = (byte) cc;p = pp;}
    }

    static final String ALU =
            "GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG"
            + "GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA"
            + "CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT"
            + "ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA"
            + "GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG"
            + "AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC"
            + "AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA";
    static final Freq[] IUB = {
        new Freq('a', 0.27),
        new Freq('c', 0.12),
        new Freq('g', 0.12),
        new Freq('t', 0.27),
        new Freq('B', 0.02),
        new Freq('D', 0.02),
        new Freq('H', 0.02),
        new Freq('K', 0.02),
        new Freq('M', 0.02),
        new Freq('N', 0.02),
        new Freq('R', 0.02),
        new Freq('S', 0.02),
        new Freq('V', 0.02),
        new Freq('W', 0.02),
        new Freq('Y', 0.02)};
    static final Freq[] HomoSapiens = {
        new Freq('a', 0.3029549426680),
        new Freq('c', 0.1979883004921),
        new Freq('g', 0.1975473066391),
        new Freq('t', 0.3015094502008)};

    static void sumAndScale(Freq[] a) {
        double p = 0;
        for (int i = 0; i < a.length; i++)
            a[i].p = (p += a[i].p) * LOOKUP_SCALE;
        a[a.length - 1].p = LOOKUP_SCALE;
    }

    static final class Randomfasta {

        static Freq[] makeLookup(Freq[] a) {
            Freq[] lookup = new Freq[LOOKUP_SIZE];
            for (int i = 0, j = 0; i < LOOKUP_SIZE; i++) {
                while (a[j].p < i) j++;
                lookup[i] = a[j];
            }
            return lookup;
        }

        static void makeLine(byte[] buffer, int bytes, Freq[] lookup) {
            for (int b = 0; b < bytes; b++){
                double r = Random.next();
                int ai = (int) r; while (lookup[ai].p < r) ai++;
                buffer[b] = lookup[ai].c;
            }
            buffer[bytes] = '\n';
        }

        static void make(String id, String desc, Freq[] a, int n, OutputStream out) throws IOException {
            out.write((">" + id + " " + desc + '\n').getBytes());
            
            Freq[] lookup = makeLookup(a);
            byte[] buffer = new byte[LINE_LENGTH + 1];
            
            while (n > 0) {
                int bytes = Math.min(LINE_LENGTH, n);
                makeLine(buffer, bytes, lookup);
                out.write(buffer, 0, bytes + 1);
                n -= bytes;
            }
        }
    }

    static final class Repeatfasta {
    
        static void make(String id, String desc, byte[] alu, int n, OutputStream out) throws IOException {
            out.write((">" + id + " " + desc + '\n').getBytes());

            byte alubBuffer[] = new byte[alu.length + LINE_LENGTH];
            for (int i = 0; i < alubBuffer.length; i += alu.length)
                System.arraycopy(alu, 0, alubBuffer, i, Math.min(alu.length, alubBuffer.length - i));

            int pos = 0;
            while (n > 0) {
                int bytes = Math.min(LINE_LENGTH, n);
                out.write(alubBuffer, pos, bytes);
                out.write('\n');
                pos = (pos + bytes) % alu.length;
                n -= bytes;
            }
        }
    }


    public static void main(String[] args) throws IOException {
        int n = 2500000;
        if (args.length > 0) 
            n = Integer.parseInt(args[0]);

        sumAndScale(IUB);
        sumAndScale(HomoSapiens);

        OutputStream out = new BufferedOutputStream(System.out,64*1024);
        Repeatfasta.make("ONE", "Homo sapiens alu", ALU.getBytes(), n * 2, out);
        Randomfasta.make("TWO", "IUB ambiguity codes", IUB, n * 3, out);
        Randomfasta.make("THREE", "Homo sapiens frequency", HomoSapiens, n * 5, out);
        out.close();
    }
}

