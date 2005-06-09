(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org
   
   contributed by Isaac Gouy (Oberon-2 novice)
*)

MODULE reversefile;
IMPORT StdChannels, Channel, Out, SYSTEM;

TYPE  
   Line = POINTER TO ARRAY 120 OF CHAR; 
   
VAR
   in: Channel.Reader;
   buffer: POINTER TO ARRAY OF CHAR;
   i, j: LONGINT;
   line: Line;
   
BEGIN
   in := StdChannels.stdin.NewReader();
   i := in.Available();   
   IF i > 0 THEN      
      NEW(buffer, i+1);
      in.ReadBytes(buffer^,0,i); buffer[i] := 0X; DEC(i);              
      IF buffer[i] = 0AX THEN DEC(i); END;
      j := i;
      WHILE j > 0 DO
         IF buffer^[i] = 0AX THEN
            line := SYSTEM.VAL(Line, SYSTEM.ADR(buffer[j]));
            Out.String(line^);
            buffer[j] := 0X;      
         END;
         j := i; DEC(i);
      END;
      line := SYSTEM.VAL(Line, SYSTEM.ADR(buffer[j]));
      Out.String(line^);
   END;   
END reversefile.
