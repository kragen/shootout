
(*
 * The Great Computer Language Shootout
 * http://shootout.alioth.debian.org
 *
 * A small library of useful utilities for the
 * programming language shootout.
 *
 *)

MODULE Shootout;

IMPORT IntStr, ProgramArgs, TextRider;

PROCEDURE Argi*() : LONGINT;
VAR n: LONGINT;
    rd: TextRider.Reader;
    line: ARRAY 256 OF CHAR;
    res: SHORTINT;
BEGIN
  n := 1;
  IF (ProgramArgs.args.ArgNumber() > 0) THEN
      rd := TextRider.ConnectReader(ProgramArgs.args);
      rd.ReadLine(line);
      LOOP
         rd.ReadLine(line);
         IF rd.res # TextRider.done THEN RETURN n; END;
         IntStr.StrToInt(line, n, res);
      END;
  END;
  RETURN n;
END Argi;



PROCEDURE Quicksort* (n: LONGINT; VAR a: ARRAY OF REAL);

PROCEDURE Swap(i, j: LONGINT);
VAR t: REAL;
BEGIN
  t := a[i]; a[i] := a[j]; a[j] := t;
END Swap;

PROCEDURE Sort(l, r: LONGINT);
VAR
  i, j: LONGINT;
  pivot: REAL;
BEGIN
  i := l;
  j := r;
  pivot := a[(l+r) DIV 2];
  REPEAT
     WHILE a[i] < pivot DO INC(i); END;
     WHILE a[j] > pivot DO DEC(j); END;
     IF i <= j THEN Swap(i, j); INC(i); DEC(j); END;
  UNTIL i > j;
  IF l < j THEN Sort(l, j); END;
  IF r > i THEN Sort(i, r); END;
END Sort;

BEGIN
  Sort(0, n-1);
END Quicksort;

END Shootout.
