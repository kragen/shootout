(* The Computer Language Shootout
   http://shootout.alioth.debian.org
   contributed by Isaac Gouy (Oberon-2 novice) *)

MODULE recursive;
IMPORT Shootout, Out;

VAR m,n: LONGINT;

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

PROCEDURE Fibf (n: REAL): REAL;
BEGIN
   IF n<2 THEN RETURN 1; ELSE RETURN Fibf(n-2) + Fibf(n-1); END;
END Fibf;

PROCEDURE Takf (x,y,z: REAL) : REAL;
BEGIN
   IF y<x THEN RETURN Takf(Takf(x-1,y,z), Takf(y-1,z,x), Takf(z-1,x,y)); 
   ELSE RETURN z; END;	
END Takf;

BEGIN
   n := Shootout.Argi();
   Out.String("Ack(3," ); Out.Int(n,0); Out.String("): "); 
   Out.Int(Ack(3,n),0); Out.Ln;

   m = n*4; 
   Out.String("Fib("); Out.Int(m,0); Out.String("): "); 
   Out.Int(Fib(m),0); Out.Ln;

   m = n+2; 
   Out.String("Tak("); Out.Int(m*3,0); Out.String(","); Out.Int(m*2,0);
   Out.String(","); Out.Int(m,0); Out.String("): "); 
   Out.Int(Tak(m*3,m*2,m),0); Out.Ln;

   m = n*5; 
   Out.String("Fib("); Out.Int(m,0); Out.String("): "); 
   Out.LongRealFix(Fibf(m*1.0),0,1); Out.Ln;

   m = n+2; 
   Out.String("Tak("); Out.Int(m*3,0); Out.String(","); Out.Int(m*2,0);
   Out.String(","); Out.Int(m,0); Out.String("): "); 
   Out.LongRealFix(Takf(m*3.0,m*2.0,m*1.0),0,1); Out.Ln;
END recursive.