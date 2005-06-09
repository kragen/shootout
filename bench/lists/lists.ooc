(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org
 
   contributed by Isaac Gouy (Oberon-2 novice)
   Line-by-line (more or less) translation of the C implemention.
*)


MODULE lists;
IMPORT Shootout, SYSTEM, Out;

CONST size = 10000;

TYPE
   List = POINTER TO ListRec;
   ListRec = RECORD
      val: LONGINT;
      next: List;
      prev: List;
   END;

VAR
   n, result: LONGINT;
   l1, l2, l3, item: List;


PROCEDURE Length (head: List): LONGINT;
BEGIN
   RETURN head.val;
END Length;


PROCEDURE Empty (head: List): BOOLEAN;
BEGIN
   RETURN Length(head) = 0;
END Empty;


PROCEDURE First (head: List): List;
BEGIN
   RETURN head.next;
END First;


PROCEDURE Last (head: List): List;
BEGIN
   RETURN head.prev;
END Last;


PROCEDURE PushTail (VAR head: List; item: List);
VAR tail: List;
BEGIN
   tail := head.prev;
   tail.next := item;
   item.next := head;
   head.prev := item;
   item.prev := tail;
   INC(head.val);
END PushTail;


PROCEDURE PopTail (VAR head: List): List;
VAR prev, tail: List;
BEGIN
   IF Empty(head) THEN RETURN NIL; END;
   tail := head.prev;
   prev := tail.prev;
   prev.next := head;
   head.prev := prev;
   DEC(head.val);
   RETURN tail;
END PopTail;


PROCEDURE PushHead (VAR head, item: List); (* never used *)
VAR next: List;
BEGIN
   next := head.next;
   head.next := item;
   next.prev := item;
   item.next := next;
   item.prev := head;
   INC(head.val);
END PushHead;


PROCEDURE PopHead (VAR head: List): List;
VAR next: List;
BEGIN
   IF Empty(head) THEN RETURN NIL; END;
   next := head.next;
   head.next := next.next;
   next.next.prev := head;
   DEC(head.val);
   RETURN next;
END PopHead;


PROCEDURE Equal (x, y: List): BOOLEAN;
VAR xp, yp: List;
BEGIN
   xp := x;
   yp := y;
   WHILE xp.next # x DO
      IF xp.val # yp.val THEN RETURN FALSE; END;
      xp := xp.next;
      yp := yp.next;
   END;
   IF xp.val # yp.val THEN RETURN FALSE; END;
   RETURN  yp.next = y;
END Equal;


PROCEDURE Print (msg: ARRAY OF CHAR; x: List); (* never used *)
VAR
   xp, first: List;
   i: LONGINT;
BEGIN
   first := x.next;
   i := 0;
   xp := x.next;;
   WHILE xp.next # first DO
      Out.String(msg);
      Out.String("i:"); Out.Int(i,3);
      Out.String("   v:"); Out.Int(xp.val,3);
      Out.String("   n:"); Out.Int(xp.next.val,3);
      Out.String("   p:"); Out.Int(xp.prev.val,3);
      Out.Ln;
      INC(i);
      xp := xp.next;
   END;
   Out.String("[last entry points to list head]"); Out.Ln;
   Out.String("[val of next of tail is: ");
   Out.Int(xp.next.val,3); Out.String("]"); Out.Ln; Out.Ln;
END Print;



PROCEDURE New (): List;
VAR l: List;
BEGIN
   NEW(l);
   l.next := l;
   l.prev := l;
   l.val := 0;
   RETURN l;
END New;


PROCEDURE Sequence (from, to: LONGINT): List;
VAR
   size, tmp, i, j: LONGINT;
   a: POINTER TO ARRAY OF ListRec;
BEGIN
   IF from > to THEN
      tmp := from; from := to; to := tmp;
   END;
   size := to - from + 1;

   NEW(a, size+1);
   DEC(from);
   j := 1;
   FOR i := 0 TO size-1 DO
      a[i].next := SYSTEM.VAL(List, SYSTEM.ADR( a[i+1] ));
      a[j].prev := SYSTEM.VAL(List, SYSTEM.ADR( a[j-1] ));
      a[i].val := from;
      INC(from);
      INC(j);
   END;
   a[0].prev := SYSTEM.VAL(List, SYSTEM.ADR( a[size] ));
   a[size].next := SYSTEM.VAL(List, SYSTEM.ADR( a[0] ));
   a[size].prev := SYSTEM.VAL(List, SYSTEM.ADR( a[size-1] ));
   a[size].val := from;
   a[0].val := size;
   RETURN SYSTEM.VAL(List, SYSTEM.ADR( a[0] ));
END Sequence;


PROCEDURE Copy (x: List): List;
VAR
   size, i, j: LONGINT;
   xp: List;
   a: POINTER TO ARRAY OF ListRec;
BEGIN
   size := Length(x);
   NEW(a, size+1);
   j := 1;
   xp := x;
   FOR i := 0 TO size-1 DO
      a[i].next := SYSTEM.VAL(List, SYSTEM.ADR( a[j] ));
      a[j].prev := SYSTEM.VAL(List, SYSTEM.ADR( a[i] ));
      a[i].val := xp.val;
      INC(j);
      xp := xp.next;
   END;
   a[0].prev := SYSTEM.VAL(List, SYSTEM.ADR( a[size] ));
   a[size].next := SYSTEM.VAL(List, SYSTEM.ADR( a[0] ));
   xp := Last(x);
   a[size].val := xp.val;
   RETURN SYSTEM.VAL(List, SYSTEM.ADR( a[0] ));
END Copy;


PROCEDURE Reverse (head: List);
VAR tmp, p: List;
BEGIN
   p := head;
   REPEAT
      tmp := p.next;
      p.next := p.prev;
      p.prev := tmp;
      p := tmp;
   UNTIL p = head;
END Reverse;


PROCEDURE TestLists (): LONGINT;
BEGIN
   l1 := Sequence(1,size); (* Print("L1 ", l1); *)
   l2 := Copy(l1);         (* Print("L2 ", l2); *)
   l3 := New();            (* Print("L3 ", l3); *)

   IF ~Equal(l2, l1) THEN
      Out.String("l2 and l1 are not equal"); Out.Ln;
      HALT(1);
   END;

   WHILE ~ Empty(l2) DO
      PushTail(l3, PopHead(l2));
   END;
                           (* Print("L2 ", l2);
			      Print("L3 ", l3); *)
   IF ~Empty(l2) THEN
      Out.String("l2 should be empty now"); Out.Ln;
      HALT(1);
   END;			
								
   WHILE ~ Empty(l3) DO
      PushTail(l2, PopTail(l3));
   END;
                           (* Print("L2 ", l2);
			      Print("L3 ", l3); *)
   IF ~Empty(l3) THEN
      Out.String("l3 should be empty now"); Out.Ln;
      HALT(1);
   END;	
   			
   Reverse(l1);            (* Print("L1 ", l1); *)

   item := First(l1);
   IF item.val # size THEN
      Out.String("L1 first value wrong, wanted "); Out.Int(size,1);
      Out.String(", got "); Out.Int(item.val,1); Out.Ln;
      HALT(1);
   END;

   item := Last(l1);
   IF item.val # 1 THEN
      Out.String("L1 last value wrong, wanted 1, got ");
      Out.Int(item.val,1); Out.Ln;
      HALT(1);
   END;

   item := First(l2);
   IF item.val # size THEN
      Out.String("L2 first value wrong, wanted "); Out.Int(size,1);
      Out.String(", got "); Out.Int(item.val,1); Out.Ln;
      HALT(1);
   END;

   item := Last(l2);
   IF item.val # 1 THEN
      Out.String("L2 last value wrong, wanted 1, got ");
      Out.Int(item.val,1); Out.Ln;
      HALT(1);
   END;

   IF Length(l1) # size THEN
      Out.String("L1 size wrong, wanted "); Out.Int(size,1);
      Out.String(", got "); Out.Int(Length(l1),1); Out.Ln;
      HALT(1);
   END;

   IF ~Equal(l1, l2) THEN
      Out.String("l1 and l2 are not equal"); Out.Ln;
      HALT(1);
   END;

   RETURN Length(l1);
END TestLists;


BEGIN
   n := Shootout.Argi();
   result := 0;
   WHILE n > 0 DO
      result := TestLists();
      DEC(n);
   END;
   Out.Int(result,1); Out.Ln;
END lists.