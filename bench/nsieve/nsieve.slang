% nsieve.sl  -- S-Lang
%
% Contributed by John E. Davis
static define nsieve(m, isprime)
{
   isprime[*] = 1;
   variable count = 0;

   _for (2,m,1) 
     {
        variable i = ();
        if (isprime[i])
          {
             isprime[[2*i:m:i]] = 0;
             count++;
          }
     }
   return count;
}

public define slsh_main ()
{
   variable n = 2;
   if (__argc > 1) n = integer (__argv[1]);
   if (n < 2) n = 2;
   variable m, flags;

   m = (1 shl n) * 10000;
   flags = UChar_Type[m+1];
   () = fprintf (stdout, "Primes up to %8d %8d\n", m, nsieve(m, flags));
   m = (1 shl (n-1)) * 10000;
   flags = UChar_Type[m+1];
   () = fprintf (stdout, "Primes up to %8d %8d\n", m, nsieve(m, flags));
   m = (1 shl (n-2)) * 10000;
   flags = UChar_Type[m+1];
   () = fprintf (stdout, "Primes up to %8d %8d\n", m, nsieve(m, flags));
   return 0;
}

% vim: ts=4 ft=slang
