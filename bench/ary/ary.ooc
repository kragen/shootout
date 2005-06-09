(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org
   
   contributed by Isaac Gouy (Oberon-2 novice)
*) 

MODULE ary;
IMPORT Shootout, Out;

VAR n, m, i, j: LONGINT;
    x, y: POINTER TO ARRAY OF LONGINT;
    
BEGIN
   n := Shootout.Argi();
   m := n-1;
   
   NEW(x, n);
   NEW(y, n);
   
   FOR i := 0 TO m DO
      x[i] := i+1;
   END;
   
   FOR j := 1 TO 1000 DO
      FOR i := 0 TO m DO
         INC(y[i], x[i]);
      END;
   END;
   
   Out.Int(y[0],1); Out.String(" "); Out.Int(y[m],1); Out.Ln;
END ary.
