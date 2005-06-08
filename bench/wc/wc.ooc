(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   contributed by Stewart Greenhill
*)


MODULE wc;
IMPORT IO, IO:StdChannels, Out;

VAR
    insideWord: BOOLEAN;
    nc, nl, nw: LONGINT;
    in : IO.ByteChannel;
    buffer : ARRAY 4096 OF CHAR;
    i, count : LONGINT;

BEGIN
    nc := 0; nl := 0; nw := 0;
    insideWord := FALSE;
    in := StdChannels.stdin;
    REPEAT
      count := in.Read(buffer, 0, LEN(buffer) * SIZE(CHAR));
      FOR i := 0 TO count-1 DO
         INC(nc);
         CASE buffer[i] OF
            | 0AX :
               INC(nl);
               insideWord := FALSE;
            | 9X, 20X :
               insideWord := FALSE;
         ELSE
            IF ~insideWord THEN
               insideWord := TRUE;
               INC(nw);
            END;
         END;
      END;
    UNTIL count <= 0;

    Out.Int(nl,1); Out.Char(20X); Out.Int(nw,0); Out.Char(20X);
    Out.Int(nc,0); Out.Ln;
END wc.