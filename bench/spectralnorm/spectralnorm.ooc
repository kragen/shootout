(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   contributed by Isaac Gouy (Oberon-2 novice)

   To run:   spectralnorm 100 
*)


MODULE spectralnorm;
IMPORT Shootout, LRealMath, Out;

TYPE Vector = POINTER TO ARRAY OF LONGREAL;
VAR
   i, n: LONGINT;
   u, v: Vector;
   vBv, vv: LONGREAL;


(* return element i,j of infinite matrix A *)
PROCEDURE A(i,j: LONGINT): LONGREAL;
BEGIN RETURN 1.0 / ((i+j)*(i+j+1) /2 +i+1); END A;


(* multiply vector v by matrix A *)
PROCEDURE MultiplyAv(v, Av: Vector);
VAR
   i,j: LONGINT;
BEGIN
   FOR i := 0 TO n-1 DO
      Av[i] := 0.0;
      FOR j := 0 TO n-1 DO Av[i] := Av[i] + A(i,j) * v[j]; END;
   END;
END MultiplyAv;


(* multiply vector v by matrix A transposed *)
PROCEDURE MultiplyAtv(v, Atv: Vector);
VAR
   i,j: LONGINT;
BEGIN
   FOR i := 0 TO n-1 DO
      Atv[i] := 0.0;
      FOR j := 0 TO n-1 DO Atv[i] := Atv[i] + A(j,i) * v[j]; END;
   END;
END MultiplyAtv;


(* multiply vector v by matrix A and then by matrix A transposed *)
PROCEDURE MultiplyAtAv(v, AtAv: Vector);
VAR
   u: Vector;
BEGIN
   NEW(u, n);    
   MultiplyAv(v, u);
   MultiplyAtv(u, AtAv);
END MultiplyAtAv;


BEGIN
   n := Shootout.Argi();

   (* create unit vector *)
   NEW(u, n);
   FOR i := 0 TO n-1 DO u[i] := 1.0; END;   

   (* 20 steps of the power method *)
   NEW(v, n);
   FOR i := 0 TO n-1 DO v[i] := 0.0; END;

   FOR i := 1 TO 10 DO
      MultiplyAtAv(u, v);
      MultiplyAtAv(v, u);
   END;

   FOR i := 0 TO n-1 DO
      vBv := vBv + u[i]*v[i];
      vv := vv + v[i]*v[i];
   END;

   Out.LongRealFix( LRealMath.sqrt(vBv/vv), 0,9); Out.Ln;
END spectralnorm.
