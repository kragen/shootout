(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   contributed by Isaac Gouy (Oberon-2 novice)

   Do the same low-level stuff as the C implementations.
*)

MODULE strcat;
IMPORT Shootout, SYSTEM, Out, Strings;

TYPE
   CharArray = ARRAY 8 OF CHAR;   
   String = POINTER TO CharArray;

VAR
   buffer, tmp: POINTER TO ARRAY OF CHAR; 
   bufferEnd: String;
   stuff: CharArray;
   n, stufflen, start, end, buflen, newbuflen: LONGINT;


(* Strings.Length only returns INTEGER, we need LONGINT *)
PROCEDURE Length(VAR a: ARRAY OF CHAR): LONGINT;
VAR i: LONGINT;
BEGIN
   i := 0;
   WHILE (i < LEN(a)) & (a[i] # 0X) DO INC(i); END; 
   RETURN i;   
END Length; 


BEGIN
   n := Shootout.Argi();
   stuff := "hello"; stuff[5] := 0AX; stuff[6] := 0X;
   stufflen := Length(stuff);   
   
   buflen := 32; NEW(buffer, buflen); buffer[0] := 0X;
   start := SYSTEM.ADR(buffer[0]);
   end := start;
   WHILE n > 0 DO 
      IF (start + buflen) - end < stufflen + 1 THEN
         newbuflen := ASH(buflen,1);
         NEW(tmp, newbuflen);
         COPY(buffer^, tmp^);
         buffer := tmp; tmp := NIL;
         DEC(end, start);
         start := SYSTEM.ADR(buffer[0]);
         INC(end, start);
         buflen := newbuflen;
      END;   
         (* much faster to strcat to strend than to strbuf! *)
      bufferEnd := SYSTEM.VAL(String, end);        
      Strings.Append(stuff, bufferEnd^);      
      INC(end, stufflen);

      DEC(n);
   END;   
        
   Out.Int( Length(buffer^), 0); Out.Ln; 
END strcat.