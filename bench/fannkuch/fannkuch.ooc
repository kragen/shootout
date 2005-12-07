(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   contributed by Isaac Gouy (Oberon-2 novice)

   To run:   fannkuch 9 
*)


MODULE fannkuch;
IMPORT Shootout, Out;

VAR n, f: LONGINT;


PROCEDURE F(n: LONGINT): LONGINT;
VAR
   perm, perm1, count, maxPerm: POINTER TO ARRAY OF LONGINT;
   check, m, r, i, k, temp, maxFlipsCount, flipsCount, perm0: LONGINT;
BEGIN
   NEW(perm, n); NEW(perm1, n); NEW(count, n); NEW(maxPerm, n);

   check := 0;
   maxFlipsCount := 0;
   m := n - 1;
   FOR i := 0 TO m DO perm1[i] := i; END;

   r := n;
   LOOP
      (* write-out the first 30 permutations *)
      IF (check < 30) THEN
         FOR i := 0 TO m DO Out.Int( perm1[i]+1, 1); END;
         Out.Ln;
         INC(check);
      END;

      WHILE r # 1 DO count[r-1] := r; DEC(r); END;
      IF ~((perm1[0]=0) OR (perm1[m]=m)) THEN
         FOR i := 0 TO m DO perm[i] := perm1[i]; END;
         flipsCount := 0;
         LOOP
            k := perm[0];	
            IF k = 0 THEN EXIT; END;
            FOR i := 0 TO ASH(k+1,-1) - 1 DO
               temp := perm[i]; perm[i] := perm[k-i]; perm[k-i] := temp;
            END;
            INC(flipsCount);	    	
         END;	
         IF flipsCount > maxFlipsCount THEN	
            maxFlipsCount := flipsCount;
            FOR i := 0 TO m DO maxPerm[i] := perm1[i]; END;
         END;
      END;
      LOOP
         IF r = n THEN RETURN maxFlipsCount; END;
         perm0 := perm1[0];
         i := 0;
         WHILE i < r DO
            k := i + 1;
            perm1[i] := perm1[k];
            i := k;
         END;
         perm1[r] := perm0;
	
         DEC(count[r]);	
         IF count[r] > 0 THEN EXIT; END;
         INC(r);
      END;
   END;
END F;


BEGIN
   n := Shootout.Argi();
   f := F(n);
   Out.String("Pfannkuchen("); Out.Int(n,1); Out.String(") = ");
   Out.Int( f, 1); Out.Ln;
END fannkuch.

