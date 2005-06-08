(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   contributed by Isaac Gouy (Oberon-2 novice)
*)


MODULE fibo;
IMPORT Shootout, Out;


PROCEDURE Fibo (n: LONGINT): LONGINT;
BEGIN
   IF n<2 THEN
      RETURN 1;
   ELSE
      RETURN Fibo(n-2) + Fibo(n-1);
   END;
END Fibo;


BEGIN
   Out.Int( Fibo( Shootout.Argi() ),0); Out.Ln;
END fibo.