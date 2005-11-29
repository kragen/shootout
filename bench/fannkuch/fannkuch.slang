#!/usr/bin/env slsh
% The Computer Language Shootout Benchmarks
% http://shootout.alioth.debian.org/
%
% contributed by John E. Davis
private define fannkuch (n)
{
   variable m = n-1;
   variable perm1 = [0:m];
   variable r0, r1, r = n;
   variable count = Int_Type[n];
   variable max_flipcounts = 0;
   variable check = 30;
   forever
     {
	if (check)
	  {
	     message(strjoin (array_map(String_Type, &string, perm1+1),""));
	     check--;
	  }
	loop (r-1) { r; r--; count[r] = (); }

	!if ((perm1[0] == 0) or (perm1[m] == m))
	  {
	     variable perm = @perm1;
	     variable flipcounts = 0;
	     forever 
	       {
		  variable k = perm[0];
		  !if (k)
		    break;
		  array_reverse (perm, 0, k);
		  flipcounts++;
	       }
	     if (flipcounts > max_flipcounts)
	       max_flipcounts = flipcounts;
	  }	
	forever
	  {
	     if (r == n)
	       return max_flipcounts;

	     variable perm0 = perm1[0];
	     r0 = 0, r1 = 1; 
	     loop (r) { perm1[r0] = perm1[r1]; r0++; r1++; }
	     perm1[r] = perm0;
	     variable cr = count[r]-1;
	     count[r] = cr;
	     if (cr > 0)
	       break;
	     r++;
	  }
     }
}

define slsh_main ()
{
   variable num = 1;
   if (__argc > 1) num = integer (__argv[1]);
   vmessage ("Pfannkuchen(%d) = %ld", num, fannkuch (num));
}
   
