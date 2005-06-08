(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   contributed by Isaac Gouy (Oberon-2 novice)
*)

MODULE random;
IMPORT Shootout, Out;

CONST
   im = 139968;
   ia = 3877;
   ic = 29573;

VAR
   n, last: LONGINT;
   result: LONGREAL;

PROCEDURE Next (max: LONGREAL): LONGREAL;
BEGIN
   last := (last*ia + ic) MOD im;
   RETURN max * last / im;
END Next;

BEGIN
   last := 42;
   n := Shootout.Argi();

   WHILE n > 0 DO
      DEC(n);
      result := Next(100.0);
   END;  	

   Out.LongRealFix(result,0,9); Out.Ln;
END random.