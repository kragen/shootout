(*
 * The Great Computer Language Shootout
 * http://shootout.alioth.debian.org
 *
 * A small library of useful utilities for the
 * programming language shootout.
 *
 *)

MODULE LangShootout;

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
	IF rd.res # TextRider.done THEN
	  RETURN n;
	END;
	IntStr.StrToInt(line, n, res);
      END;
  END;
  RETURN n;
END Argi;

END LangShootout.
