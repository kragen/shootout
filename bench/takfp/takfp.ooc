(* $Id: takfp.ooc,v 1.1 2005-06-08 18:03:26 igouy-guest Exp $

   The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   Contributed by Brent Fulgham
 *)

MODULE takfp;
IMPORT Shootout, Out;

VAR N: LONGINT;

PROCEDURE Tak (x,y,z: REAL) : REAL;
BEGIN
	IF (y >= x) THEN RETURN z; END;
	RETURN Tak(Tak(x-1,y,z), Tak(y-1,z,x), Tak(z-1,x,y));
END Tak;

BEGIN
	N := Shootout.Argi();
	Out.LongRealFix( Tak( N * 3.0, N * 2.0, N * 1.0),0, 1); Out.Ln;
END takfp.

 
