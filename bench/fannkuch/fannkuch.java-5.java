/*
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * Contributed by Oleg Mazurov, May 2010
 *
 */

import java.util.concurrent.atomic.AtomicInteger;

public final class fannkuch implements Runnable
{
    private static final int TOPRINT = 30;
    private static final int NCHUNKS = 75;
    private static       int CHUNKSZ;
    private static int n;
    private static int[] Fact;
    private static int[] maxFlips;
    private static AtomicInteger taskId;
    
    int[] p, pp, count;

    void print()
    {
        for ( int i = 0; i < p.length; i++ ) {
            System.out.print( p[i] + 1 );
        }
        System.out.println();
    }

    int procInterval( int idxMin, int idxMax )
    {
        // First permutation
        for ( int i=0; i<p.length; ++i ) {
           p[i] = i;
        }

        int idx = idxMin;
        for ( int i=count.length-1; i>0; --i ) {
            int d = idx / Fact[i];
            count[i] = d;
            idx = idx % Fact[i];

            System.arraycopy( p, 0, pp, 0, i+1 );
            for ( int j=0; j<=i; ++j ) {
                p[j] = j+d <= i ? pp[j+d] : pp[j+d-i-1];
            }
        }
        if ( idxMin < TOPRINT ) {
            print();
        }

        int maxflips = 1;
        loop: for ( int i=idxMin; i<idxMax; ++i ) {

            // Count flips
            int first = p[0];
            if ( p[first] != 0 ) {
                int flips = 1;
                System.arraycopy( p, 0, pp, 0, pp.length );
                do {
                     ++flips;
                     for ( int lo = 1, hi = first - 1; lo < hi; ++lo, --hi ) {
                        int t = pp[lo];
                        pp[lo] = pp[hi];
                        pp[hi] = t;
                     }
                     int t = pp[first];
                     pp[first] = first;
                     first = t;
                } while ( pp[first] != 0 );
                maxflips = Math.max( maxflips, flips );
            }

            // Next permutation
            next: for ( int k=1;;) {
                int t = p[0];
                for ( int l=0; l<k; ++l ) {
                    p[l] = p[l+1];
                }
                p[k] = t;
                if ( ++count[k] > k ) {
                    count[k] = 0;
                    if ( ++k == count.length ) {
                        break loop;
                    }
                }
                else if ( i < TOPRINT-1 ) {
                    print();
                    break;
                }
                else {
                    for ( int l=k; l>0; --l ) {
                        if ( p[l] == l ) {
                            i += Fact[l];
                            k = Math.max( l, 1 );
                            continue next;
                        }
                    }
                    break;
                }
            }
        }

        return maxflips;
    }

    public void run()
    {
        p     = new int[n];
        pp    = new int[n];
        count = new int[n];        

        int task;
        while ( ( task = taskId.getAndIncrement() ) < maxFlips.length ) {
            int idxMin = task*CHUNKSZ;
            int idxMax = Math.min( Fact[n], idxMin+CHUNKSZ );
            if ( idxMin > 0 && idxMax <= Fact[n-1] ) continue;
            maxFlips[task] = procInterval( idxMin, idxMax );
        }
    }

    static void printResult( int n, int res )
    {
        System.out.println( "Pfannkuchen("+n+") = "+res );
    }

    public static void main( String[] args )
    {        
        n = args.length > 0 ? Integer.parseInt( args[0] ) : 12;
        if ( n <= 1 ) {
            printResult( n, 0 );
            return;
        }
        if ( n > 12 ) {         // 13! won't fit into int
            printResult( n, -1 );
            return;
        }

        Fact = new int[n+1];
        Fact[0] = 1;
        for ( int i=1; i<Fact.length; ++i ) {
            Fact[i] = Fact[i-1] * i;
        }
        
        CHUNKSZ = Math.max( (Fact[n] + NCHUNKS - 1) / NCHUNKS, TOPRINT );
        maxFlips = new int[(Fact[n] + CHUNKSZ - 1) / CHUNKSZ];
        taskId = new AtomicInteger(0);

        int nthreads = Runtime.getRuntime().availableProcessors();
        Thread[] threads = new Thread[nthreads];
        for ( int i=0; i<nthreads; ++i ) {
            threads[i] = new Thread( new fannkuch() );
            threads[i].start();
        }
        for ( Thread t : threads ) {
            try {
                t.join();
            }
            catch ( InterruptedException e ) {}
        }
        
        int res = 0;
        for ( int v : maxFlips ) {
            res = Math.max( res, v );
        }
        printResult( n, res );
    }
}
