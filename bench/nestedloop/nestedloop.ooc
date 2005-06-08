(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   contributed by Isaac Gouy (Oberon-2 novice)
*)


MODULE nestedloop;
IMPORT Shootout, Out;

VAR n, count, g, h, i, j, k, l: LONGINT;

BEGIN
   n := Shootout.Argi();
   count := 0;

   FOR g := 1 TO n DO
      FOR h := 1 TO n DO
         FOR i := 1 TO n DO
            FOR j := 1 TO n DO
               FOR k := 1 TO n DO
                  FOR l := 1 TO n DO
                     INC(count);
                  END;
               END;
            END;
         END;
      END;
   END;  	
		
   Out.Int(count,1); Out.Ln;
END nestedloop.
