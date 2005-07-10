#!/usr/bin/env slsh
% The Great Computer Language Shootout
% http://shootout.alioth.debian.org/
% 
% contributed by John E Davis

define slsh_main ()
{
   variable n = 10000000, dn = 4096, s=0.0;
   if (__argc > 1) n = integer (__argv[1]);
   while (n > dn)
   {
      variable n0 = n-dn;
      s += sum (1.0/[n0:n]);
      n = n0-1;
   }
   s += sum (1.0/[1:n]);
   ()=fprintf (stdout, "%.9f\n", s);
}
