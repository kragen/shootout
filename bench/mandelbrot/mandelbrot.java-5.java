/* The Computer Language Benchmarks Game
http://shootout.alioth.debian.org/

contributed by Stefan Krause
slightly modified by Chad Whipkey
parallelized by Colin D Bennett 2008-10-04
reduce synchronization cost by The Anh Tran
optimizations and refactoring by Enotus 2010-11-11
 */


import java.io.*;
import java.util.concurrent.atomic.AtomicInteger;

public final class mandelbrot {
    static byte[][] out;
    static AtomicInteger yCt;
    static double[] Crb;
    static double[] Cib;

    static int get8(int x, int y){
        double Ci = Cib[y];
        int res=0;
        for(int i=0;i<8;i+=2){
            double Cr1=Crb[x+i];
            double Cr2=Crb[x+i+1];
            
            double Tr1=Cr1*Cr1;
            double Tr2=Cr2*Cr2;

            double Zr1=Cr1;
            double Zr2=Cr2;

            double Zi1=Ci;
            double Zi2=Ci;

            double Ti1=Ci*Ci;
            double Ti2=Ci*Ci;

            int b=0;
            for(int j=0;j<49;j++){
                Zi1=Zr1*Zi1+Zr1*Zi1+Ci;
                Zi2=Zr2*Zi2+Zr2*Zi2+Ci;
                Zr1=Tr1-Ti1+Cr1;
                Zr2=Tr2-Ti2+Cr2;
                Ti1=Zi1*Zi1;
                Ti2=Zi2*Zi2;
                Tr1=Zr1*Zr1;
                Tr2=Zr2*Zr2;
                if(Tr1+Ti1>4){ b|=2;}
                if(Tr2+Ti2>4){ b|=1;}
                if(b==3) break;
            }
            res=(res<<2)+b;
        }
        return res^-1;
    }

    static void putLine(final int y, final byte[] line){
        for (int xb=0; xb<line.length; xb++) line[xb]=(byte)get8(xb*8,y);
    }

    public static void main(String[] args) throws Exception {
        int size = 6000;
        if (args.length >= 1)  size=Integer.parseInt(args[0]);

        Crb=new double[size]; Cib=new double[size];
        double invN=2.0/size; for(int i=0;i<size;i++){ Cib[i]=i*invN-1.0; Crb[i]=i*invN-1.5; }
        yCt = new AtomicInteger(0);
        out=new byte[size][(size+7)/8];

        Thread[] pool = new Thread[Runtime.getRuntime().availableProcessors()+1];
        for (int i=0;i<pool.length;i++)
            pool[i]=new Thread()
                {public void run() {int y; while ( (y=yCt.getAndIncrement()) < out.length ) putLine(y,out[y]);}};
        for (Thread t:pool) t.start();
        for (Thread t:pool) t.join();

        BufferedOutputStream ostream = new BufferedOutputStream(System.out);
        ostream.write(("P4\n"+size+" "+size+"\n").getBytes());
        for (int i = 0; i < size; i++) ostream.write(out[i]);
        ostream.close();
    }
    
}

