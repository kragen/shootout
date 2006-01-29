(* The Computer Language Shootout
   http://shootout.alioth.debian.org
   contributed by Isaac Gouy (Oberon-2 novice) *)

MODULE recursive;
IMPORT Shootout, Out;

VAR n: LONGINT;

PROCEDURE Ack (m, n: LONGINT): LONGINT;
BEGIN
   IF m=0 THEN RETURN n+1; END;
   IF n=0 THEN RETURN Ack(m-1, 1); END;
   RETURN Ack(m-1, Ack(m, n-1));
END Ack;

PROCEDURE Fib (n: LONGINT): LONGINT;
BEGIN
   IF n<2 THEN RETURN 1; ELSE RETURN Fib(n-2) + Fib(n-1); END;
END Fib;

PROCEDURE Tak (x,y,z: LONGINT) : LONGINT;
BEGIN
   IF y<x THEN RETURN Tak(Tak(x-1,y,z), Tak(y-1,z,x), Tak(z-1,x,y)); 
   ELSE RETURN z; END;	
END Tak;

PROCEDURE Fibr (n: LONGREAL): LONGREAL;
BEGIN
   IF n<2.0D+00 THEN RETURN 1.0D+00; 
   ELSE RETURN Fibr(n-2.0D+00) + Fibr(n-1.0D+00); END;
END Fibr;

PROCEDURE Takr (x,y,z: LONGREAL) : LONGREAL;
BEGIN
   IF y<x THEN RETURN 
      Takr( Takr(x-1.0D+00,y,z), Takr(y-1.0D+00,z,x), Takr(z-1.0D+00,x,y) ); 
   ELSE RETURN z; END;	
END Takr;

BEGIN
   n := Shootout.Argi();

   Out.String("Ack(3,"); Out.Int(n,0); Out.String("): "); 
   Out.Int(Ack(3,n),0); Out.Ln;

   Out.String("Fib("); Out.LongRealFix(27.0+n,0,1); Out.String("): "); 
   Out.LongRealFix(Fibr(27.0+n),0,1); Out.Ln;

   DEC(n); 
   Out.String("Tak("); Out.Int(n*3,0); Out.String(","); Out.Int(n*2,0);
   Out.String(","); Out.Int(n,0); Out.String("): "); Out.Int(Tak(n*3,n*2,n),0); Out.Ln;

   Out.String("Fib(3): "); Out.Int(Fib(3),0); Out.Ln;
   Out.String("Tak(3.0,2.0,1.0): "); Out.LongRealFix(Takr(3.0,2.0,1.0),0,1); Out.Ln;
END recursive.
