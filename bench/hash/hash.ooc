(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   SimpleHash is a line-by-line transliteration
   of the C implementation.

   contributed by Isaac Gouy (Oberon-2 novice)
*)

MODULE hash;
IMPORT Shootout, SimpleHash, Strings, IntStr, Out, S:=SYSTEM;

CONST
   maxLength = 11; 

VAR
   buffer: ARRAY maxLength OF CHAR;
   n, i, count: LONGINT;
   table: SimpleHash.Hashtable;
   item: SimpleHash.Item;
   key: SimpleHash.ItemKey;

PROCEDURE HexToItemKey(n: LONGINT): SimpleHash.ItemKey;
VAR
   i, m, digits: LONGINT;
   key: SimpleHash.ItemKey;
BEGIN
   i := maxLength - 1;
   WHILE n > 0 DO
      m := S.VAL(LONGINT, S.VAL(SET, n) * {0..3}); 
      CASE m OF
         | 0..9 : buffer[i] := CHR(ORD("0") + m);
      ELSE
                  buffer[i] := CHR(ORD("A") - 10 + m);   
      END;      
      n := ASH(n,-4); DEC(i);                  
   END;
   
   INC(i); digits := maxLength - i; 
   NEW(key, digits);
   S.MOVE(S.ADR(buffer[i]), S.VAL(LONGINT,key), digits);
   RETURN key;
END HexToItemKey;


PROCEDURE IntToItemKey(n: LONGINT): SimpleHash.ItemKey;
VAR
   digits: LONGINT;
   key: SimpleHash.ItemKey;
BEGIN
   IntStr.IntToStr(n,buffer);
   digits := Strings.Length(buffer);
   NEW(key, digits);
   S.MOVE(S.ADR(buffer[0]), S.VAL(LONGINT,key), digits); 
   RETURN key;
END IntToItemKey;


BEGIN
   n := Shootout.Argi();
   table := SimpleHash.New(n);

   FOR i := 1 TO n DO
      key := HexToItemKey(i);
      item := SimpleHash.AddKey(table, key);
      item.value := i; 	
   END;

   count := 0;
   FOR i := n TO 1 BY -1 DO
      key := IntToItemKey(i);
      IF SimpleHash.Find(table, key) # NIL THEN INC(count); END;
   END;
   Out.Int(count, 1); Out.Ln; 
END hash.