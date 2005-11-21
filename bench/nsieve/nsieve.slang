#!/usr/bin/env slsh
% The Computer Language Shootout Benchmarks
% http://shootout.alioth.debian.org/
%
% contributed by John E. Davis

private define nsieve (m, isprime)
{
   variable count = 0;
   variable i = 2;
   while (i <= m)
     {
	i = wherefirst (isprime, i);
	if (i == NULL)
	  break;

	isprime[[2*i::i]] = 0;
	i++;
	count++;
     }
   return count;
}

public define slsh_main ()
{
   variable n = 2;
   if (__argc > 1) n = integer (__argv[1]);
   if (n < 2) n = 2;
   variable m, flags;

   foreach m (10000 * (1 shl [n, n-1, n-2]))
     {
	flags = not (UChar_Type[m+1]);
	vmessage ("Primes up to %8d %8d", m, nsieve(m, flags));
     }
   return 0;
}

