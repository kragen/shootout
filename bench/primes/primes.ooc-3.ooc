(* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org
   contributed by Isaac Gouy (Oberon-2 novice)
*)

MODULE primes;
IMPORT Shootout, Out, LRealMath;

VAR
   n, i: LONGINT;


PROCEDURE Prime(n: LONGINT): LONGINT;
VAR
   count, primeNumber, k, limit, i: LONGINT;
   isTrivial: BOOLEAN;
BEGIN
   IF n < 2 THEN
      IF n = 1 THEN count := 1; primeNumber := 2; END;
   ELSE
      count := 2; primeNumber := 3;
   END;

   k := 5;
   WHILE count < n DO
      IF ((k+1) MOD 6 = 0) OR ((k-1) MOD 6 = 0) THEN

         isTrivial := TRUE;
         limit := ENTIER(LRealMath.sqrt(k));

         i := 5;
         LOOP
            IF i > limit THEN EXIT END;
            IF k MOD i = 0 THEN isTrivial := FALSE; EXIT END;
            INC(i,2);
         END;

         IF isTrivial THEN INC(count); primeNumber := k; END;
      END;
      INC(k,2);
   END;

   RETURN primeNumber;
END Prime;


BEGIN
   n := Shootout.Argi();

   Out.String("1st prime is "); Out.Int(Prime(1),1); Out.Ln;
   Out.String("2nd prime is "); Out.Int(Prime(2),1); Out.Ln;

   i := 10*n;
   WHILE i <= 50*n DO
      Out.Int(i,1); Out.String("th prime is "); Out.Int(Prime(i),1); Out.Ln;
      INC(i,10*n);
   END;
END primes.
