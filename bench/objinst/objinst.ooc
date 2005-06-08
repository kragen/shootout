(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   contributed by Isaac Gouy (Oberon-2 novice)


See:
OBJECT-ORIENTED PROGRAMMING IN OBERON-2
http://www.cas.mcmaster.ca/~kahl/SE3E03/2002/Oberon2/Oberon2.OOP.pdf
*)

MODULE objinst;
IMPORT Shootout, Out;

TYPE
   ToggleDesc = RECORD
      state: BOOLEAN;
   END;

   Toggle = POINTER TO ToggleDesc;


   NthToggleDesc = RECORD (ToggleDesc)
      countMax, counter: LONGINT;
   END;

   NthToggle = POINTER TO NthToggleDesc;

VAR
   n, i: LONGINT;
   toggle: Toggle;
   ntoggle: NthToggle;


PROCEDURE NewToggle(state: BOOLEAN): Toggle;
VAR t: Toggle;
BEGIN
   NEW(t); t.state := state;
   RETURN t;
END NewToggle;

PROCEDURE (t:Toggle) Activate();
BEGIN
   t.state := ~t.state;
END Activate;

PROCEDURE (t:Toggle) Value(): BOOLEAN;
BEGIN
   RETURN t.state;
END Value;


PROCEDURE NewNthToggle(state: BOOLEAN; countMax: LONGINT): NthToggle;
VAR t: NthToggle;
BEGIN
   NEW(t);
   t.counter := 0;
   t.state := state;
   t.countMax := countMax;
   RETURN t;
END NewNthToggle;

PROCEDURE (t:NthToggle) Activate();
BEGIN
   INC(t.counter);
   IF t.counter >= t.countMax THEN
      t.state := ~t.state;
      t.counter := 0;
   END;
END Activate;


BEGIN
   n := Shootout.Argi();

   toggle := NewToggle(TRUE);
   FOR i := 1 TO 5 DO
      toggle.Activate();
      IF toggle.Value() THEN Out.String("true");
                        ELSE Out.String("false"); END;
      Out.Ln;
   END;

   FOR i := 1 TO n DO toggle := NewToggle(TRUE); END;

   Out.Ln;
   ntoggle := NewNthToggle(TRUE,3);
   FOR i := 1 TO 8 DO
      ntoggle.Activate();
      IF ntoggle.Value() THEN Out.String("true");
                         ELSE Out.String("false"); END;
      Out.Ln;
   END;
   FOR i := 1 TO n DO ntoggle := NewNthToggle(TRUE,3); END;
END objinst.