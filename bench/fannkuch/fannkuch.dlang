/* The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   converted to D by Dave Fladebo
   compile: dmd -O -inline -release fannkuch.d
*/

import std.math, std.stdio, std.string;

void main(char[][] args)
{
    int n = args.length > 1 ? atoi(args[1]) : 1;
    writefln("Pfannkuchen(",n,") = ",F(n));
}

int F(int n)
{
    int[] perm = new int[n], perm1 = new int[n], count = new int[n], maxPerm = new int[n];
    int m = n - 1, r = n, i, k, temp, maxFlipsCount = 0, flipsCount, perm0;

    foreach(int i, inout int p; perm1) p = i;
    for(;;)
    {
        while(r != 1) { count[r-1] = r; r--; }
        if( !(perm1[0] == 0 || perm1[m] == m) )
        {
            foreach(int i, int p; perm1) perm[i] = p;
            flipsCount = 0;
            for(;;)
            {
                k = perm[0];
                if(k == 0) break;
                int k2 = (k+1) >> 1;
                for(i = 0; i < k2; i++)
                {
                   temp = perm[i]; perm[i] = perm[k-i]; perm[k-i] = temp;
                }
                flipsCount++;
            }
            if(flipsCount > maxFlipsCount)
            {
                maxFlipsCount = flipsCount;
                foreach(int i, int p; perm1) maxPerm[i] = p;
            }
        }
        for(;;)
        {
            if(r == n) return(maxFlipsCount);
            perm0 = perm1[0];
            i = 0;
            while(i < r)
            {
                k = i + 1;
                perm1[i] = perm1[k];
                i = k;
            }
            perm1[r] = perm0;

            count[r]--;
            if(count[r] > 0) break;
            r++;
        }
    }
}
