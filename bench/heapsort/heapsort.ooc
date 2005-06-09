(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   contributed by Isaac Gouy (Oberon-2 novice)
*) 

MODULE heapsort;
IMPORT Shootout, Random, Out;

VAR
   n, i: LONGINT;
   x:  POINTER TO ARRAY OF LONGREAL;


PROCEDURE Heapsort(n: LONGINT; VAR ra: ARRAY OF LONGREAL);
VAR i, j, k, ir: LONGINT;
    rra: LONGREAL;
BEGIN
   ir := n;
   k := n DIV 2 + 1;
   LOOP
      IF k > 1 THEN
         DEC(k);
         rra := ra[k];
      ELSE
         rra := ra[ir];
         ra[ir] := ra[1];
         DEC(ir);
         IF ir = 1 THEN
            ra[1] := rra;
            EXIT;
         END;
      END;
      
      i := k;
      j := ASH(k,1);

      WHILE j<=ir DO
         IF (j < ir) & (ra[j] < ra[j+1]) THEN INC(j); END;
         IF rra < ra[j] THEN
            ra[i] := ra[j];
            i := j;
            INC(j,j);
         ELSE
            j := ir + 1;
         END;
      END;	
      ra[i] := rra;
   END;
END Heapsort;


BEGIN
   n := Shootout.Argi();
   
   NEW(x, n+1);
   x[0] := 0.0;
   FOR i := 1 TO n DO x[i] := Random.Next(1.0); END;
   Heapsort(n, x^);
   Out.LongRealFix(x[n],0,10); Out.Ln;
END heapsort.
