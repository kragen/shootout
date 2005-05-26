(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org
   
   Oberon2 version of simple-hash.h
   
   contributed by Isaac Gouy (Oberon-2 novice)
*)

MODULE SimpleHash;

CONST
   Nil = CHR(0);
   
TYPE
   ItemKey* = POINTER TO ARRAY OF CHAR;
   Item* = POINTER TO ItemDesc;
   ItemDesc = RECORD
      key*: ItemKey;
      value*: LONGINT;
      next: Item;
    END;
    
   Table* = POINTER TO ARRAY OF Item;
   Hashtable* = POINTER TO HashtableDesc;
   HashtableDesc = RECORD
      size: LONGINT;
      tbl: Table;
      iterIndex: LONGINT;
      iterNext: Item;
      items: LONGINT;
    END;
    
VAR
   Primes: ARRAY 25 OF LONGINT;
   
PROCEDURE Hash* (ht: Hashtable; key: ItemKey): LONGINT;
VAR i, val: LONGINT;
BEGIN
   val := 0; i := 0;
   WHILE (i < LEN(key^)) & (key[i] # Nil) DO 
      val := 5 * val + ORD(key[i]); INC(i);
   END; 
   
   (* FOR i := 0 TO LEN(key^) - 1 DO val := 5 * val + ORD(key[i]); END; *)   
   RETURN val MOD ht.size;
END Hash;

PROCEDURE NewItem (aKey: ItemKey): Item;
VAR item: Item;
BEGIN
   NEW(item);
   item.key := aKey;
   item.value := 0;
   item.next := NIL;
   RETURN item;
END NewItem;

PROCEDURE New* (size: LONGINT): Hashtable;
VAR i: LONGINT;
    ht: Hashtable;
BEGIN
   NEW(ht);
   i := 0;
   WHILE Primes[i] < size DO INC(i); END;
   ht.size := Primes[i];
   NEW(ht.tbl, ht.size);
   ht.iterIndex := 0;
   ht.iterNext := NIL;
   ht.items := 0;
   FOR i := 0 TO ht.size-1 DO ht.tbl[i] := NIL; END;
   RETURN ht;
END New;

PROCEDURE Find* (ht: Hashtable; key: ItemKey): Item;
VAR hashcode: LONGINT;
    item: Item;
BEGIN
   hashcode := Hash(ht, key);
   item := ht.tbl[hashcode];
   WHILE item # NIL DO
      IF key^ = item.key^ THEN
         RETURN item;
      END;
      item := item.next;
   END;
   RETURN NIL;
END Find;

PROCEDURE AddKey* (ht: Hashtable; key: ItemKey): Item;
VAR hashcode: LONGINT;
    prev, item, newitem: Item;
BEGIN
   prev := NIL;
   hashcode := Hash(ht, key);
   item := ht.tbl[hashcode];
   WHILE item # NIL DO
      IF key^ = item.key^ THEN
         RETURN item;
      END;
      prev := item;
      item := item.next;
   END;
   INC(ht.items);
   newitem := NewItem(key);
   IF prev # NIL THEN
      prev.next := newitem;
   ELSE
      ht.tbl[hashcode] := newitem;
   END;
   RETURN newitem;
END AddKey;

PROCEDURE Next* (ht: Hashtable): Item;
VAR index: LONGINT;
    item: Item;
BEGIN
   item := ht.iterNext;
   IF item # NIL THEN
      ht.iterNext := item.next;
      RETURN item;
   ELSE
      WHILE ht.iterIndex < ht.size DO
         index := ht.iterIndex;
         INC(ht.iterIndex);	 	
         IF ht.tbl[index] # NIL THEN
            ht.iterNext := ht.tbl[index].next;	
            RETURN ht.tbl[index];
         END;
      END;
   END;
   RETURN NIL;
END Next;

PROCEDURE First* (ht: Hashtable): Item;
BEGIN
   ht.iterIndex := 0;
   ht.iterNext := NIL;

   RETURN Next(ht);
END First;

PROCEDURE Count* (ht: Hashtable): LONGINT;
BEGIN
   RETURN ht.items;
END Count;


BEGIN
   Primes[0] := 53;         Primes[1] := 97;         Primes[2] := 193; 
   Primes[3] := 389;        Primes[4] := 769;        Primes[5] := 1543; 
   Primes[6] := 3079;       Primes[7] := 6151;       Primes[8] := 12289; 
   Primes[9] := 24593;      Primes[10] := 49157;     Primes[11] := 98317; 
   Primes[12] := 196613;    Primes[13] := 393241;    Primes[14] := 786433; 
   Primes[15] := 1572869;   Primes[16] := 3145739;   Primes[17] := 6291469;    
   Primes[18] := 12582917;  Primes[19] := 25165843;  Primes[20] := 50331653; 
   Primes[21] := 100663319; Primes[22] := 201326611; Primes[23] := 402653189;     
   Primes[24] := 805306457;
END SimpleHash.
