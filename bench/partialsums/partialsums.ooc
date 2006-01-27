(* The Computer Language Shootout
   http://shootout.alioth.debian.org
   contributed by Isaac Gouy (Oberon-2 novice) *)

MODULE partialsums;
IMPORT Shootout, Out, LRealMath;

CONST
   twothirds = 2.0/3.0;
VAR
   k, n: LONGINT;
   a1, a2, a3, a4, a5, a6, a7, a8, a9, k2, k3, sk, ck, alt: LONGREAL;

PROCEDURE WriteLn(VAR a: LONGREAL; name: ARRAY OF CHAR);
BEGIN Out.LongRealFix(a,0,9); Out.Char(9X); Out.String(name); Out.Ln; END WriteLn;

BEGIN
   n := Shootout.Argi();
   alt := -1.0D+00;

   FOR k := 1 TO n DO 
      k2 := LRealMath.power(k,2.0D+00);
      k3 := k2*k;
      sk := LRealMath.sin(k);
      ck := LRealMath.cos(k);
      alt := -alt;

      a1 := a1 + LRealMath.power(twothirds,k-1.0D+00);
      a2 := a2 + LRealMath.power(k,-0.5D+00);
      a3 := a3 + 1.0D+00/(k*(k+1.0D+00));
      a4 := a4 + 1.0D+00/(k3*(sk*sk));
      a5 := a5 + 1.0D+00/(k3*(ck*ck));
      a6 := a6 + 1.0D+00/k;
      a7 := a7 + 1.0D+00/k2;
      a8 := a8 + alt/k;
      a9 := a9 + alt/(2.0D+00*k -1.0D+00);
   END;

   WriteLn(a1,"(2/3)^k");
   WriteLn(a2,"k^-0.5");
   WriteLn(a3,"1/k(k+1)");
   WriteLn(a4,"Flint Hills");
   WriteLn(a5,"Cookson Hills");
   WriteLn(a6,"Harmonic");
   WriteLn(a7,"Riemann Zeta");
   WriteLn(a8,"Alternating Harmonic"); 
   WriteLn(a9,"Gregory");
END partialsums.
