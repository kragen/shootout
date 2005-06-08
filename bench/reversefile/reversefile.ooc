(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   contributed by Isaac Gouy (Oberon-2 novice)
*)

MODULE reversefile;
IMPORT IO, IO:StdChannels, S:=SYSTEM, Out;
  
CONST
   readSize = 4096 * 4; 
   maxLineSize = 120; 
  
TYPE  
   LinkedBuffer = POINTER TO LinkedBufferRec;
   LinkedBufferRec = RECORD
      prev: LinkedBuffer;
      contents: ARRAY readSize OF CHAR;
   END;

   Line = POINTER TO ARRAY maxLineSize OF CHAR; 

VAR
   channel: IO.ByteChannel;
   b, b2: LinkedBuffer;
   i, j: LONGINT;
   line: Line;

BEGIN
   NEW(b); channel := StdChannels.stdin;  
   LOOP   
      TRY
         i := channel.Read(b.contents, 0, readSize * SIZE(CHAR)); 
         IF i = readSize THEN 
            NEW(b2); b2.prev := b; b := b2; 
         ELSE 
            EXIT; 
         END;                      
      CATCH IO.Error:
         HALT(1);
      END; 
   END;
   
   b.contents[i] := 0X; DEC(i);                
   IF b.contents[i] = 0AX THEN DEC(i); END;
   LOOP
      WHILE i >= 0 DO
         IF b.contents[i] = 0AX THEN
            line := S.VAL(Line, S.ADR(b.contents[i+1])); Out.String(line^);             
            b.contents[i+1] := 0X;                              
         END;
         DEC(i);
      END;
      
      IF b.prev # NIL THEN
         b2 := b; b := b.prev; i := readSize-1;
         IF b.contents[i] = 0AX THEN DEC(i); END;
         
         WHILE (i >= 0) & (b.contents[i] # 0AX) DO DEC(i); END;
         IF i < 0 THEN HALT(1); END; 
         
         FOR j := i+1 TO readSize-1 DO Out.Char(b.contents[j]); END;
         line := S.VAL(Line, S.ADR(b2.contents[0])); Out.String(line^);
         b.contents[i+1] := 0X; b2 := b; DEC(i);      
      ELSE
         line := S.VAL(Line, S.ADR(b.contents[0])); Out.String(line^); EXIT;
      END;
   END;                  
END reversefile.