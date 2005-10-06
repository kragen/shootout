module: nsieve
author: Eric Kidd <eric.kidd@pobox.com>

define function nsieve(limit :: <integer>) => result :: <integer>;
   let flags = make(<byte-vector>, size: limit + 1, fill: 1);
   let count = 0;

   for (i from 2 below limit )
      if ( flags[i] > 0)
         for (k from (i * 2) below limit by i)
	     flags[k] := 0;
         end for;
         count := count + 1;
      end if;
   end for;

   count;
end function nsieve;

begin
   let n = string-to-integer(element(application-arguments(), 0, default: "1"));

   let m = (2 ^ n) * 10000;
   format-out("Primes up to %8d %8d\n", m, nsieve(m));

   m := (2 ^ (n - 1)) * 10000;
   format-out("Primes up to %8d %8d\n", m, nsieve(m));

   m := (2 ^ (n - 2)) * 10000;
   format-out("Primes up to %8d %8d\n", m, nsieve(m));
end;
