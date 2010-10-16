/*
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * Contributed by Oleg Mazurov, October 2010
 *
 * This version is submitted for comparison purpose only.
 * It's intended to show the effect of array bound check elimination in Java.
 */

import java.util.concurrent.atomic.AtomicInteger;

public final class fannkuchredux implements Runnable
{
    private static final int NCHUNKS = 240;
    private static       int CHUNKSZ;
    private static       int NTASKS;
    private static int n;
    private static int[] Fact;
    private static int[] maxFlips;
    private static int[] chkSums;
    private static AtomicInteger taskId;
    
    int[] p, pp, count;

    public fannkuchredux()
    {
        p     = new int[n];
        pp    = new int[n];
        count = new int[n+1];
    }

    void runTask( int task )
    {
        int idxMin = task*CHUNKSZ;
        int idxMax = Math.min( Fact[n], idxMin+CHUNKSZ );

	// first permutation
        for ( int i=0; i<n; ++i ) {
           p[i] = i;
        }
        for ( int i=n-1, idx=idxMin; i>0; --i ) {
            int d = idx / Fact[i];
            count[i] = d;
            idx = idx % Fact[i];

            System.arraycopy( p, 0, pp, 0, i+1 );
            for ( int j=0; j<=i; ++j ) {
                p[j] = j+d <= i ? pp[j+d] : pp[j+d-i-1];
            }
        }

        int p0=0,p1=0,p2=0,p3=0,p4=0,p5=0,p6=0,p7=0,p8=0,p9=0,p10=0,p11=0;
	switch ( n ) {
	case 12:  p11 = p[11];
	case 11:  p10 = p[10];
	case 10:  p9 = p[9];
	case 9:   p8 = p[8];
	case 8:   p7 = p[7];
	case 7:   p6 = p[6];
	case 6:   p5 = p[5];
	case 5:   p4 = p[4];
	case 4:   p3 = p[3];
	case 3:   p2 = p[2];
	case 2:   p1 = p[1];
	case 1:   p0 = p[0];
	}

        int maxflips = 0;
        int chksum = 0;

        for ( int i=idxMin; i<idxMax; ++i ) {

	    // count flips
            if ( p0 != 0 ) {
		int pp0 = p0, pp1 = p1, pp2 = p2, pp3 = p3, pp4 = p4, pp5 = p5,
		    pp6 = p6, pp7 = p7, pp8 = p8, pp9 = p9, pp10 = p10, pp11 = p11;
	        int flips = 1;
		for ( ;; ++flips ) {
		    int t = pp0;
		    switch ( t ) {
		    case 1: pp0 = pp1; pp1 = t; break;
		    case 2: pp0 = pp2; pp2 = t; break;
		    case 3: pp0 = pp3; pp3 = t;
	        	    t = pp2; pp2 = pp1; pp1 = t;
			    break;
		    case 4: pp0 = pp4; pp4 = t;
			    t = pp3; pp3 = pp1; pp1 = t;
			    break;
		    case 5: pp0 = pp5; pp5 = t;
			    t = pp4; pp4 = pp1; pp1 = t;
			    t = pp3; pp3 = pp2; pp2 = t;
			    break;
		    case 6: pp0 = pp6; pp6 = t;
			    t = pp5; pp5 = pp1; pp1 = t;
			    t = pp4; pp4 = pp2; pp2 = t;
			    break;
		    case 7: pp0 = pp7; pp7 = t;
			    t = pp6; pp6 = pp1; pp1 = t;
			    t = pp5; pp5 = pp2; pp2 = t;
			    t = pp4; pp4 = pp3; pp3 = t;
			    break;
		    case 8: pp0 = pp8; pp8 = t;
			    t = pp7; pp7 = pp1; pp1 = t;
			    t = pp6; pp6 = pp2; pp2 = t;
			    t = pp5; pp5 = pp3; pp3 = t;
			    break;
		    case 9: pp0 = pp9; pp9 = t;
			    t = pp8; pp8 = pp1; pp1 = t;
			    t = pp7; pp7 = pp2; pp2 = t;
			    t = pp6; pp6 = pp3; pp3 = t;
			    t = pp5; pp5 = pp4; pp4 = t;
			    break;
		    case 10: pp0 = pp10; pp10 = t;
			    t = pp9; pp9 = pp1; pp1 = t;
			    t = pp8; pp8 = pp2; pp2 = t;
			    t = pp7; pp7 = pp3; pp3 = t;
			    t = pp6; pp6 = pp4; pp4 = t;
			    break;
		    case 11: pp0 = pp11; pp11 = t;
			    t = pp10; pp10 = pp1; pp1 = t;
			    t = pp9; pp9 = pp2; pp2 = t;
			    t = pp8; pp8 = pp3; pp3 = t;
			    t = pp7; pp7 = pp4; pp4 = t;
			    t = pp6; pp6 = pp5; pp5 = t;
			    break;
		    }
		    if ( pp0 == 0 ) break;
		}

                maxflips = Math.max( maxflips, flips );
		chksum += (i&1)==0 ? flips : -flips;
            }

	    // next permutation
	    int t = p0; p0 = p1; p1 = t;
            int k=1; 
            while ( ++count[k] > k ) {
		count[k++] = 0;
		switch ( k ) {
		case 11: t = p11; p11 = p0; p0 = t;
		case 10: t = p10; p10 = p0; p0 = t;
		case 9:  t = p9; p9 = p0; p0 = t;
		case 8:  t = p8; p8 = p0; p0 = t;
		case 7:  t = p7; p7 = p0; p0 = t;
		case 6:  t = p6; p6 = p0; p0 = t;
		case 5:  t = p5; p5 = p0; p0 = t;
		case 4:  t = p4; p4 = p0; p0 = t;
		case 3:  t = p3; p3 = p0; p0 = t;
		case 2:  t = p2; p2 = p0; p0 = p1; p1 = t;
		}
            }
        }

	maxFlips[task] = maxflips;
	chkSums[task]  = chksum;
    }

    public void run()
    {
        int task;
        while ( ( task = taskId.getAndIncrement() ) < NTASKS ) {
	    runTask( task );
        }
    }

    static void printResult( int n, int res, int chk )
    {
        System.out.println( chk+"\nPfannkuchen("+n+") = "+res );
    }

    public static void main( String[] args )
    {
	// Inititalize
        n = args.length > 0 ? Integer.parseInt( args[0] ) : 12;
        if ( n <= 0 || n > 12 ) {         // 13! won't fit into int
            printResult( n, -1, -1 );
            return;
        }

        Fact = new int[n+1];
        Fact[0] = 1;
        for ( int i=1; i<Fact.length; ++i ) {
            Fact[i] = Fact[i-1] * i;
        }
        
        CHUNKSZ = (Fact[n] + NCHUNKS - 1) / NCHUNKS;
	NTASKS = (Fact[n] + CHUNKSZ - 1) / CHUNKSZ;
        maxFlips = new int[NTASKS];
        chkSums  = new int[NTASKS];
        taskId = new AtomicInteger(0);

	// Go parallel 
        int nthreads = Runtime.getRuntime().availableProcessors()-1;
        Thread[] threads = new Thread[nthreads];
        for ( int i=0; i<nthreads; ++i ) {
            threads[i] = new Thread( new fannkuchredux() );
            threads[i].start();
        }
	new fannkuchredux().run();
        for ( Thread t : threads ) {
            try {
                t.join();
            }
            catch ( InterruptedException e ) {}
        }
        
	// Reduce the results
        int res = 0;
        for ( int v : maxFlips ) {
            res = Math.max( res, v );
        }
        int chk = 0;
        for ( int v : chkSums ) {
            chk += v;
        }
        
        printResult( n, res, chk );
    }
}
