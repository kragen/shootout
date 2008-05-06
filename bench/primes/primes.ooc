(* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org
   contributed by Isaac Gouy (Oberon-2 novice)
*)

MODULE primes;
IMPORT Shootout, Out, LRealMath;

VAR
   n, i: LONGINT;


PROCEDURE IsPrime(k: LONGINT): BOOLEAN;
VAR
   limit, i: LONGINT;
BEGIN
   IF k < 2 THEN RETURN FALSE;
   ELSIF k < 4 THEN RETURN TRUE;
   ELSIF ~ODD(k) THEN RETURN FALSE;
   ELSIF ((k+1) MOD 6 # 0) & ((k-1) MOD 6 # 0) THEN RETURN FALSE;
   ELSE
      limit := ENTIER(LRealMath.sqrt(k));
      FOR i := 5 TO limit BY 2 DO 
         IF k MOD i = 0 THEN RETURN FALSE; END;
      END;
   END;
   RETURN TRUE;
END IsPrime;


PROCEDURE Prime(n: LONGINT): LONGINT;
VAR
   count, k: LONGINT;
BEGIN
   count := 0; 
   k := 1;
   WHILE count < n DO
      IF IsPrime(k) THEN INC(count); END;
      INC(k);
   END;
   RETURN k-1;
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
