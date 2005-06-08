(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   contributed by Isaac Gouy (Oberon-2 novice)
*)


MODULE ackermann;
IMPORT Out, ProgramArgs, TextRider;

VAR n: LONGINT;

PROCEDURE Ack (m, n: LONGINT): LONGINT;
BEGIN
   IF m=0 THEN RETURN n+1; END;
   IF n=0 THEN RETURN Ack(m-1, 1); END;
   RETURN Ack(m-1, Ack(m, n-1));
END Ack;


(* We'll put this in a library module Shootout *)
PROCEDURE Argi* (): LONGINT;
VAR
   value: LONGINT;
   r: TextRider.Reader; 
BEGIN
   r := TextRider.ConnectReader(ProgramArgs.args);
   IF (r # NIL) & (ProgramArgs.args.ArgNumber() > 0) THEN
      r.ReadLn;
      r.ReadLInt(value);
      IF r.res # TextRider.done THEN
         value := 1;
      END;
   ELSE
      value := 1;
   END;
   RETURN value;
END Argi;


BEGIN
   n := Argi();
   Out.String("Ack(3," ); Out.Int(n,0); Out.String("): ");
   Out.Int( Ack(3,n), 0); Out.Ln;
END ackermann.