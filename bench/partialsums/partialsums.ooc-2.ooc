(* The Computer Language Shootout
   http://shootout.alioth.debian.org
   contributed by Isaac Gouy (Oberon-2 novice) *)

MODULE partialsums;
IMPORT Shootout, Out, M := LRealMath;

VAR
   k, n: LONGINT;
   sum, a: LONGREAL;

PROCEDURE WriteLn(VAR sum: LONGREAL; VAR name: ARRAY OF CHAR);
BEGIN Out.LongRealFix(sum,0,9); Out.Char(9X); Out.String(name); Out.Ln; END WriteLn;

BEGIN
   n := Shootout.Argi();

   FOR k := 0 TO n-1 DO sum := sum + M.power(2.0/3.0,k); END;
   WriteLn(sum,"(2/3)^k");

   sum := 0;
   FOR k := 1 TO n DO sum := sum + M.power(k,-0.5D+00); END;
   WriteLn(sum,"k^-0.5");

   sum := 0;
   FOR k := 1 TO n DO sum := sum + 1.0D+00/(k*(k+1.0D+00)); END;
   WriteLn(sum,"1/k(k+1)");

   sum := 0;
   FOR k := 1 TO n DO 
      sum := sum + 1.0D+00/( M.power(k,3) * M.power(M.sin(k),2.0D+00) ); END;
   WriteLn(sum,"Flint Hills");

   sum := 0;
   FOR k := 1 TO n DO 
      sum := sum + 1.0D+00/( M.power(k,3) * M.power(M.cos(k),2.0D+00) ); END;
   WriteLn(sum,"Cookson Hills");

   sum := 0;
   FOR k := 1 TO n DO sum := sum + 1.0D+00/k; END;
   WriteLn(sum,"Harmonic");

   sum := 0;
   FOR k := 1 TO n DO sum := sum + 1.0D+00/M.power(k,2.0D+00); END;
   WriteLn(sum,"Riemann Zeta");

   sum := 0; a := -1.0D+00;
   FOR k := 1 TO n DO a := -a; sum := sum + a/k; END;
   WriteLn(sum,"Alternating Harmonic"); 

   sum := 0; a := -1.0D+00;
   FOR k := 1 TO n DO a := -a; sum := sum + a/(2.0D+00*k -1.0D+00); END;
   WriteLn(sum,"Gregory");
END partialsums.
