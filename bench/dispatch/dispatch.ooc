(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org
   
   contributed by Isaac Gouy (Oberon-2 novice)  
   
   Unoptimised ***procedural*** implementation 
   
   Note: Oberon-2 does provide type-extension and
   type-bound procedures (virtual methods).
   
   We might package the multiple implementations of
   corresponding procedures in separate named modules. 
   For example: 
      EmptyState.Next() and FullState.Next()
   
   Here the procedures are just prefixed so we can keep 
   everything in a single source file. 
   So, for example:
      ES_Next() and FS_Next()
*)


MODULE dispatch;
IMPORT Shootout, Out;

CONST
   ES_Tag = 1;
   FS_Tag = 2;
   SS_Tag = 3;

   UE_Tag = 4;
   UF_Tag = 5;
   PU_Tag = 6;
   PS_Tag = 7;

TYPE
   IB_State = POINTER TO IB_StateDesc;
   IB_StateDesc = RECORD
      tag : INTEGER;
   END;

   IB_Bottle = POINTER TO IB_BottleDesc;
   IB_BottleDesc = RECORD
      state : IB_State;
      id : INTEGER;
   END;

VAR
   IB_Empty ,IB_Full ,IB_Sealed : IB_State;

   IB_UnpressurizedEmpty ,IB_UnpressurizedFull
      ,IB_PressurizedUnsealed ,IB_PressurizedSealed : IB_State;

   b1, b2, b3, b4, b5, b6, b7, b8, b9, b0 : IB_Bottle;
   p1, p2, p3, p4, p5, p6, p7, p8, p9, p0 : IB_Bottle;

   n, i, check : LONGINT;



(* IBottle Module *)

PROCEDURE IB_SetState (b: IB_Bottle; s: IB_State);
BEGIN b.state := s; END IB_SetState;


PROCEDURE IB_NewBottle (id: INTEGER): IB_Bottle;
VAR
   b : IB_Bottle;
BEGIN
   NEW(b); b.id := id; b.state := IB_Empty;
   RETURN b;
END IB_NewBottle;


PROCEDURE IB_NewPressurizedBottle (id: INTEGER): IB_Bottle;
VAR
   b : IB_Bottle;
BEGIN
   NEW(b); b.id := id; b.state := IB_UnpressurizedEmpty;
   RETURN b;
END IB_NewPressurizedBottle;


PROCEDURE IB_NewState (VAR s: IB_State; tag: INTEGER);
BEGIN NEW(s); s.tag := tag; END IB_NewState;



(* EmptyState Module *)

PROCEDURE ES_Next (b: IB_Bottle);
BEGIN
   IB_SetState(b, IB_Full);
END ES_Next;



(* FullState Module *)

PROCEDURE FS_Next (b: IB_Bottle);
BEGIN
   IB_SetState(b, IB_Sealed);
END FS_Next;



(* SealedState Module *)

PROCEDURE SS_Next (b: IB_Bottle);
BEGIN
   IB_SetState(b, IB_Empty);
END SS_Next;



(* Bottle Module *)

PROCEDURE B_DispatchNext (b: IB_Bottle);
BEGIN
   CASE b.state.tag OF
        ES_Tag : ES_Next(b);
      | FS_Tag : FS_Next(b);
      | SS_Tag : SS_Next(b);                
   END;   
END B_DispatchNext;


PROCEDURE B_Empty (b: IB_Bottle);
BEGIN B_DispatchNext(b); END B_Empty;


PROCEDURE B_Fill (b: IB_Bottle);
BEGIN B_DispatchNext(b); END B_Fill;


PROCEDURE B_Seal (b: IB_Bottle);
BEGIN B_DispatchNext(b); END B_Seal;


PROCEDURE B_Cycle (b: IB_Bottle);
BEGIN B_Fill(b); B_Seal(b); B_Empty(b); END B_Cycle;


PROCEDURE B_Check0 (b: IB_Bottle; c: LONGINT): LONGINT;
BEGIN RETURN b.state.tag + b.id + c; END B_Check0;


PROCEDURE B_New (id: INTEGER): IB_Bottle;
BEGIN RETURN IB_NewBottle(id); END B_New;


PROCEDURE B_Check (a1,a2,a3,a4,a5: IB_Bottle; i: LONGINT): LONGINT;
VAR
   c : LONGINT;
BEGIN
   B_Cycle(a1); B_Cycle(a2); B_Cycle(a3); B_Cycle(a4); B_Cycle(a5);

   c := i MOD 2;

   RETURN B_Check0(a1,c) + B_Check0(a2,c)
      + B_Check0(a3,c) + B_Check0(a4,c) + B_Check0(a5,c);
END B_Check;



(* UnpressurizedEmptyState Module *)

PROCEDURE UE_Next (b: IB_Bottle);
BEGIN
   IB_SetState(b, IB_UnpressurizedFull);
END UE_Next;



(* UnpressurizedFullState Module *)

PROCEDURE UF_Next (b: IB_Bottle);
BEGIN
   IB_SetState(b, IB_PressurizedUnsealed);
END UF_Next;



(* PressurizedUnsealedState Module *)

PROCEDURE PU_Next (b: IB_Bottle);
BEGIN
   IB_SetState(b, IB_PressurizedSealed);
END PU_Next;



(* PressurizedSealedState Module *)

PROCEDURE PS_Next (b: IB_Bottle);
BEGIN
   IB_SetState(b, IB_UnpressurizedEmpty);
END PS_Next;



(* PressurizedBottle Module *)

PROCEDURE PB_DispatchNext (b: IB_Bottle);
BEGIN
   CASE b.state.tag OF
        UE_Tag : UE_Next(b);
      | UF_Tag : UF_Next(b);
      | PU_Tag : PU_Next(b);
      | PS_Tag : PS_Next(b);                  
   END;
END PB_DispatchNext;


PROCEDURE PB_Empty (b: IB_Bottle);
BEGIN PB_DispatchNext(b); END PB_Empty;


PROCEDURE PB_Fill (b: IB_Bottle);
BEGIN PB_DispatchNext(b); END PB_Fill;


PROCEDURE PB_Seal (b: IB_Bottle);
BEGIN PB_DispatchNext(b); END PB_Seal;


PROCEDURE PB_Pressurize (b: IB_Bottle);
BEGIN PB_DispatchNext(b); END PB_Pressurize;


PROCEDURE PB_Cycle (b: IB_Bottle);
BEGIN PB_Fill(b); PB_Pressurize(b); PB_Seal(b); PB_Empty(b); END PB_Cycle;


PROCEDURE PB_New (id: INTEGER): IB_Bottle;
BEGIN RETURN IB_NewPressurizedBottle(id); END PB_New;


PROCEDURE PB_Check (a1,a2,a3,a4,a5: IB_Bottle; i: LONGINT): LONGINT;
VAR
   c : LONGINT;
BEGIN
   PB_Cycle(a1); PB_Cycle(a2); PB_Cycle(a3); PB_Cycle(a4); PB_Cycle(a5);

   c := i MOD 2;

   RETURN B_Check0(a1,c) + B_Check0(a2,c)
      + B_Check0(a3,c) + B_Check0(a4,c) + B_Check0(a5,c);
END PB_Check;




(* FlyweightState Module *)

BEGIN
   IB_NewState(IB_Empty, ES_Tag);
   IB_NewState(IB_Full, FS_Tag);
   IB_NewState(IB_Sealed, SS_Tag);

   IB_NewState(IB_UnpressurizedEmpty, UE_Tag);
   IB_NewState(IB_UnpressurizedFull, UF_Tag);
   IB_NewState(IB_PressurizedUnsealed, PU_Tag);
   IB_NewState(IB_PressurizedSealed, PS_Tag);


   n := Shootout.Argi();

   b1 := B_New(1); b2 := B_New(2);
   b3 := B_New(3); b4 := B_New(4);
   b5 := B_New(5); b6 := B_New(6);
   b7 := B_New(7); b8 := B_New(8);
   b9 := B_New(9); b0 := B_New(0);

   p1 := PB_New(1); p2 := PB_New(2);
   p3 := PB_New(3); p4 := PB_New(4);
   p5 := PB_New(5); p6 := PB_New(6);
   p7 := PB_New(7); p8 := PB_New(8);
   p9 := PB_New(9); p0 := PB_New(0);

   check := 0;
   FOR i := 1 TO n DO
      INC(check, B_Check(b1,b2,b3,b4,b5,i));
      INC(check, B_Check(b6,b7,b8,b9,b0,i));

      INC(check, PB_Check(p1,p2,p3,p4,p5,i));
      DEC(check, PB_Check(p6,p7,p8,p9,p0,i));
   END;

   Out.Int(check,1); Out.Ln;
END dispatch.