(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org
   
   contributed by Isaac Gouy (Oberon-2 novice)
*)

MODULE Random;

CONST
   IM = 139968;
   IA = 3877;
   IC = 29573;
   
VAR
   last: LONGINT;
   
PROCEDURE Next* (max: LONGREAL): LONGREAL;
BEGIN
   last := (last*IA + IC) MOD IM;
   RETURN max * last / IM;
END Next;

BEGIN
   last := 42;
END Random.
