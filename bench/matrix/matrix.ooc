(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   contributed by Isaac Gouy (Oberon-2 novice)
*)

MODULE matrix;
IMPORT Shootout, Out;

CONST
   size = 30;
   rowSize = size;
   rowLast = rowSize - 1;
   colSize = size;
   colLast = colSize - 1;

TYPE
   Matrix = ARRAY rowSize, colSize OF LONGINT;

VAR
   n: LONGINT;
   m1, m2, mm: Matrix;


PROCEDURE MakeMatrix(VAR m: Matrix);
VAR i, j, count: LONGINT;
BEGIN
   count := 1;
   FOR i := 0 TO rowLast DO
      FOR j := 0 TO colLast DO
         m[i,j] := count;
         INC(count);
      END;
   END;
END MakeMatrix;


PROCEDURE MatrixMultiply(leftm, rightm: Matrix; VAR m: Matrix);
VAR i, j, k, sumOfProduct: LONGINT;
BEGIN
   FOR i := 0 TO rowLast DO
      FOR j := 0 TO colLast DO
         sumOfProduct := 0;
	 FOR k := 0 TO colLast DO
            INC(sumOfProduct, leftm[i,k] * rightm[k,j]);
         END;
	 m[i,j] := sumOfProduct;
      END;
   END;
END MatrixMultiply;


BEGIN
   n := Shootout.Argi();

   MakeMatrix(m1);
   MakeMatrix(m2);

   WHILE n > 0 DO
      DEC(n);
      MatrixMultiply(m1, m2, mm);
   END;

   Out.Int(mm[0,0],0); Out.Char(20X); Out.Int(mm[2,3],0); Out.Char(20X);
   Out.Int(mm[3,2],0); Out.Char(20X); Out.Int(mm[4,4],0); Out.Ln;
END matrix.