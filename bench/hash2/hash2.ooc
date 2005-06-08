(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   SimpleHash is a line-by-line transliteration
   of the C implementation.

   contributed by Isaac Gouy (Oberon-2 novice)
*)

MODULE hash2;
IMPORT Shootout, SimpleHash, Strings, IntStr, Out, S:=SYSTEM;

CONST
   maxLength = 11;

VAR
   buffer: ARRAY maxLength OF CHAR;
   n, i: LONGINT;
   table1, table2: SimpleHash.Hashtable;
   item1, item2: SimpleHash.Item;
   key, key1, key9999: SimpleHash.ItemKey;   


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
   table1 := SimpleHash.New(10000);
   table2 := SimpleHash.New(10000);

   FOR i := 0 TO 9999 DO
      key := IntToItemKey(i);
      item1 := SimpleHash.AddKey(table1, key);
      item1.value := i;
   END;

   FOR i := 0 TO n-1 DO
      item1 := SimpleHash.First(table1);
      WHILE item1 # NIL DO
         item2 := SimpleHash.AddKey(table2, item1.key);
	 INC(item2.value, item1.value);
	 item1 := SimpleHash.Next(table1);
      END;
   END;

   key1 := IntToItemKey(1);
   key9999 := IntToItemKey(9999);

   item1 := SimpleHash.Find(table1, key1);
   Out.Int(item1.value, 1); Out.Char(20X);
   item1 := SimpleHash.Find(table1, key9999);
   Out.Int(item1.value, 0); Out.Char(20X);
   item2 := SimpleHash.Find(table2, key1);
   Out.Int(item2.value, 0); Out.Char(20X);
   item2 := SimpleHash.Find(table2, key9999);
   Out.Int(item2.value, 0); Out.Ln;
END hash2.