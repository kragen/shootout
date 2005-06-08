(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org 

   contributed by Isaac Gouy (Oberon-2 novice)

   To run:   harmonic 1000000
*)

MODULE harmonic;
IMPORT Shootout, Out;

VAR
   i, n: LONGINT;
   partialSum, d: LONGREAL;

BEGIN
   n := Shootout.Argi();

   WHILE i < n DO
      d := d + 1.0D+00;
      partialSum := partialSum + (1.0D+00/d);
      INC(i);
   END;

   Out.LongRealFix(partialSum,0,9); Out.Ln;
END harmonic.
