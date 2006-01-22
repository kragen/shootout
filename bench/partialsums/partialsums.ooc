(* The Computer Language Shootout
   http://shootout.alioth.debian.org
   contributed by Isaac Gouy (Oberon-2 novice) *)

MODULE partialsums;
IMPORT Shootout, Out, M := LRealMath;

VAR
   k, n: LONGINT;
   sum, a: LONGREAL;

BEGIN
   n := Shootout.Argi();

   WHILE k < n DO sum := sum + M.power(2.0/3.0,k); INC(k); END;
   Out.LongRealFix(sum,0,9); Out.Char(9X); Out.String("(2/3)^k"); Out.Ln;

   k := 0; sum := 0;
   WHILE k < n DO INC(k); sum := sum + M.power(k,-0.5D+00); END;
   Out.LongRealFix(sum,0,9); Out.Char(9X); Out.String("k^-0.5"); Out.Ln;

   k := 0; sum := 0;
   WHILE k < n DO INC(k); sum := sum + 1.0D+00/(k*(k+1)); END;
   Out.LongRealFix(sum,0,9); Out.Char(9X); Out.String("1/k(k+1)"); Out.Ln;

   k := 0; sum := 0;
   WHILE k < n DO INC(k); 
      sum := sum + 1.0D+00/( M.power(k,3) * M.power(M.sin(k),2.0D+00) ); END;
   Out.LongRealFix(sum,0,9); Out.Char(9X); Out.String("Flint Hills"); Out.Ln;

   k := 0; sum := 0;
   WHILE k < n DO INC(k); 
      sum := sum + 1.0D+00/( M.power(k,3) * M.power(M.cos(k),2.0D+00) ); END;
   Out.LongRealFix(sum,0,9); Out.Char(9X); Out.String("Cookson Hills"); Out.Ln;

   k := 0; sum := 0;
   WHILE k < n DO INC(k); sum := sum + 1.0D+00/k; END;
   Out.LongRealFix(sum,0,9); Out.Char(9X); Out.String("Harmonic"); Out.Ln;

   k := 0; sum := 0;
   WHILE k < n DO INC(k); sum := sum + 1.0D+00/M.power(k,2.0D+00); END;
   Out.LongRealFix(sum,0,9); Out.Char(9X); Out.String("Riemann Zeta"); Out.Ln;

   k := 0; sum := 0; a := -1.0D+00;
   WHILE k < n DO INC(k); a := -a; sum := sum + a/k; END;
   Out.LongRealFix(sum,0,9); Out.Char(9X); Out.String("Alternating Harmonic"); Out.Ln;

   k := 0; sum := 0; a := -1.0D+00;
   WHILE k < n DO INC(k); a := -a; sum := sum + a/(2.0D+00*k -1.0D+00); END;
   Out.LongRealFix(sum,0,9); Out.Char(9X); Out.String("Gregory"); Out.Ln;
END partialsums.
