(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org
   
   contributed by Isaac Gouy (Oberon-2 novice)
   
   Unoptimised implementation
*)


MODULE dispatch;
IMPORT Shootout, Out;

TYPE
   BottleState = POINTER TO BottleStateDesc;
   BottleStateDesc = RECORD
      tag : INTEGER;
   END;

   EmptyState = POINTER TO EmptyStateDesc;
   EmptyStateDesc = RECORD (BottleStateDesc) END;

   FullState = POINTER TO FullStateDesc;
   FullStateDesc = RECORD (BottleStateDesc) END;

   SealedState = POINTER TO SealedStateDesc;
   SealedStateDesc = RECORD (BottleStateDesc) END;


   PressurizedBottleStateDesc = RECORD (BottleStateDesc) END;

   UnpressurizedEmptyState = POINTER TO UnpressurizedEmptyStateDesc;
   UnpressurizedEmptyStateDesc = RECORD (PressurizedBottleStateDesc) END;

   UnpressurizedFullState = POINTER TO UnpressurizedFullStateDesc;
   UnpressurizedFullStateDesc = RECORD (PressurizedBottleStateDesc) END;

   PressurizedUnsealedState = POINTER TO PressurizedUnsealedStateDesc;
   PressurizedUnsealedStateDesc = RECORD (PressurizedBottleStateDesc) END;

   PressurizedSealedState = POINTER TO PressurizedSealedStateDesc;
   PressurizedSealedStateDesc = RECORD (PressurizedBottleStateDesc) END;


   Bottle = POINTER TO BottleDesc;
   BottleDesc = RECORD
      state : BottleState;
      id : INTEGER;
   END;

   PressurizedBottle = POINTER TO PressurizedBottleDesc;
   PressurizedBottleDesc = RECORD (BottleDesc) END;


VAR
   Empty : EmptyState;
   Full : FullState;
   Sealed : SealedState;

   UnpressurizedEmpty : UnpressurizedEmptyState;
   UnpressurizedFull : UnpressurizedFullState;
   PressurizedUnsealed : PressurizedUnsealedState;
   PressurizedSealed : PressurizedSealedState;

   b1, b2, b3, b4, b5, b6, b7, b8, b9, b0 : Bottle;
   p1, p2, p3, p4, p5, p6, p7, p8, p9, p0 : PressurizedBottle;

   n, i, check : LONGINT;



PROCEDURE (s: BottleState) Tag (tag: INTEGER);
BEGIN s.tag := tag; END Tag;

PROCEDURE (b: Bottle) SetState (s: BottleState);
BEGIN b.state := s; END SetState;



PROCEDURE (s: BottleState) Next (b: Bottle);
BEGIN  END Next;

PROCEDURE (s: EmptyState) Next (b: Bottle);
BEGIN b.SetState(Full); END Next;

PROCEDURE (s: FullState) Next (b: Bottle);
BEGIN b.SetState(Sealed); END Next;

PROCEDURE (s: SealedState) Next (b: Bottle);
BEGIN b.SetState(Empty); END Next;



PROCEDURE (s: UnpressurizedEmptyState) Next (b: Bottle);
BEGIN b.SetState(UnpressurizedFull); END Next;

PROCEDURE (s: UnpressurizedFullState) Next (b: Bottle);
BEGIN b.SetState(PressurizedUnsealed); END Next;

PROCEDURE (s: PressurizedUnsealedState) Next (b: Bottle);
BEGIN b.SetState(PressurizedSealed); END Next;

PROCEDURE (s: PressurizedSealedState) Next (b: Bottle);
BEGIN b.SetState(UnpressurizedEmpty); END Next;



PROCEDURE (b: Bottle) Id (id: INTEGER);
BEGIN b.id := id; b.state := Empty; END Id;

PROCEDURE (b: Bottle) Empty ();
BEGIN b.state.Next(b); END Empty;

PROCEDURE (b: Bottle) Fill ();
BEGIN b.state.Next(b); END Fill;

PROCEDURE (b: Bottle) Seal ();
BEGIN b.state.Next(b); END Seal;

PROCEDURE (b: Bottle) Cycle ();
BEGIN b.Fill(); b.Seal(); b.Empty(); END Cycle;

PROCEDURE (b: Bottle) Check0 (c: LONGINT): LONGINT;
BEGIN RETURN b.state.tag + b.id + c; END Check0;

PROCEDURE Check (a1,a2,a3,a4,a5: Bottle; i: LONGINT): LONGINT;
VAR
   c : LONGINT;
BEGIN
   a1.Cycle(); a2.Cycle(); a3.Cycle(); a4.Cycle(); a5.Cycle();

   c := i MOD 2;
   RETURN a1.Check0(c) + a2.Check0(c) + a3.Check0(c) + a4.Check0(c) + a5.Check0(c);
END Check;



PROCEDURE (b: PressurizedBottle) Id (id: INTEGER);
BEGIN b.id := id; b.state := UnpressurizedEmpty; END Id;

PROCEDURE (b: PressurizedBottle) Pressurize ();
BEGIN b.state.Next(b); END Pressurize;

PROCEDURE (b: PressurizedBottle) Cycle ();
BEGIN b.Fill(); b.Pressurize(); b.Seal(); b.Empty(); END Cycle;



BEGIN
   NEW(Empty); Empty.Tag(1);
   NEW(Full); Full.Tag(2);
   NEW(Sealed); Sealed.Tag(3);

   NEW(UnpressurizedEmpty); UnpressurizedEmpty.Tag(4);
   NEW(UnpressurizedFull); UnpressurizedFull.Tag(5);
   NEW(PressurizedUnsealed); PressurizedUnsealed.Tag(6);
   NEW(PressurizedSealed); PressurizedSealed.Tag(7);

   n := Shootout.Argi();

   NEW(b1); b1.Id(1); NEW(b2); b2.Id(2); NEW(b3); b3.Id(3); NEW(b4); b4.Id(4);
   NEW(b5); b5.Id(5); NEW(b6); b6.Id(6); NEW(b7); b7.Id(7); NEW(b8); b8.Id(8);
   NEW(b9); b9.Id(9); NEW(b0); b0.Id(0);

   NEW(p1); p1.Id(1); NEW(p2); p2.Id(2); NEW(p3); p3.Id(3); NEW(p4); p4.Id(4);
   NEW(p5); p5.Id(5); NEW(p6); p6.Id(6); NEW(p7); p7.Id(7); NEW(p8); p8.Id(8);
   NEW(p9); p9.Id(9); NEW(p0); p0.Id(0);

   check := 0;
   FOR i := 1 TO n DO
      INC(check, Check(b1,b2,b3,b4,b5,i));
      INC(check, Check(b6,b7,b8,b9,b0,i));

      INC(check, Check(p1,p2,p3,p4,p5,i));
      DEC(check, Check(p6,p7,p8,p9,p0,i));
   END;

   Out.Int(check,1); Out.Ln;
END dispatch.