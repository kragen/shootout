(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   contributed by Isaac Gouy (Oberon-2 novice)
*)

MODULE sumcol;
IMPORT In, IntConv, Out;

CONST
   maxLineSize = 120;
VAR 
   line: ARRAY maxLineSize OF CHAR;
   sum: LONGINT;
BEGIN
   sum := 0;
   LOOP
      In.Line(line);           
      IF line[0] = 0X THEN EXIT; END;    
      INC(sum, IntConv.ValueInt(line)); 
   END;
   Out.Int(sum, 0); Out.Ln;
END sumcol.