(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   contributed by Isaac Gouy (Oberon-2 novice)
*)

MODULE sieve;
IMPORT Shootout, Out;

CONST
   start = 2;
   stop = 8192;
   size = stop+1;

VAR
   n, count, i, k: LONGINT;
   isPrimeNumber: ARRAY size OF BOOLEAN;

BEGIN
   n := Shootout.Argi();
   WHILE n > 0 DO
      DEC(n);
      count := 0;      
      FOR i := start TO stop DO isPrimeNumber[i] := TRUE; END;
      FOR i := start TO stop DO
         IF isPrimeNumber[i] THEN
            INC(count);
            k := i+i;
            WHILE k <= stop DO
               isPrimeNumber[k] := FALSE;
               INC(k, i);
            END;
         END;
      END;
   END;  	

   Out.String("Count: "); Out.Int(count,0); Out.Ln;
END sieve.