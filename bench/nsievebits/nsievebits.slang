#!/usr/bin/env slsh
% The Computer Language Shootout Benchmarks
% http://shootout.alioth.debian.org/
%
% contributed by John E. Davis
private define nsieve(m)
{
   variable i, j, k, l, count, flags;
   count = 0; m--; flags = UChar_Type[(m+8)/8];
   _for (2, 7, 1)
     {
	i = (); j = i/8; 
	if (flags[j] & (1 shl (i mod 8))) continue;
	i = [2*i:m:i]; j = i/8;	i = (1 shl (i mod 8));
	k = [0:length(i)-9:8];
	loop (8)
	  {
	     l = j[k]; flags[l] = flags[l] | i[k];
	     k++;
	  }
	count++;
     }
   _for (8,m,1) 
     {
	i = ();
	if (flags[i/8] & (1 shl (i mod 8)))
	  continue;

	count++;
	if (i*4 < m)
	  {
	     i = [2*i:m:i]; j = i/8;
	     flags[j] = flags[j] | (1 shl (i mod 8));
	     continue;
	  }
	_for (2*i, m, i)
	  {
	     i = (); j = i/8;
	     flags[j] = flags[j] | (1 shl (i mod 8));
	  }
     }
   return count;
}

define slsh_main ()
{
   variable n = 2; if (__argc > 1) n = integer (__argv[1]);
   if (n < 2) n = 2;
   variable m, i, flags;

   _for (0, 2, 1)
     {
	i = ();
	m = (1 shl (n-i)) * 10000;
	() = fprintf (stdout, "Primes up to %8d %8d\n", m, nsieve(m));
     }
}

