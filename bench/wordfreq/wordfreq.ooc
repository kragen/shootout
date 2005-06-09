(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   contributed by Isaac Gouy (Oberon-2 novice)
*)


MODULE wordfreq;
IMPORT IO, IO:StdChannels, S:=SYSTEM, SimpleHash, Out;
		
CONST
   readSize = 4096;		
		
TYPE
   FixedBuffer = ARRAY readSize OF CHAR;
   FixedBufferProc = PROCEDURE (VAR b: FixedBuffer; VAR pos: LONGINT);   		
		
VAR
   buffer: FixedBuffer; 
   wordCounts: SimpleHash.Hashtable;   

   i, size: LONGINT; 
   item: SimpleHash.Item;
   items: SimpleHash.Table;


(* Separate special processing in procedure Process so we can use
   FillAndProcess in other Shootout tests *)
PROCEDURE FillAndProcess (VAR buffer: FixedBuffer; Process: FixedBufferProc);
VAR
   channel: IO.ByteChannel;
   partialFill: BOOLEAN;
   size, pos, count: LONGINT;
BEGIN
   channel := StdChannels.stdin;
   pos := 0;
   size := readSize;
   LOOP
      TRY
         count := channel.Read(buffer, pos, size * SIZE(CHAR)); 
         partialFill := count < size; 
         IF partialFill THEN size := pos + count; ELSE size := readSize; END;               
         pos := size;	

         Process(buffer,pos);

         IF partialFill THEN EXIT; END;  
         
         IF pos = size THEN 
            pos := 0;
            size := readSize;
         ELSE
            S.MOVE(S.ADR(buffer[pos]), S.ADR(buffer[0]), (size-pos)*SIZE(CHAR));
            pos := size - pos;
            size := readSize - pos;
         END;   
                      
      CATCH IO.Error:
         EXIT;
      END;               
   END;
END FillAndProcess;


PROCEDURE CountWords(VAR buffer: FixedBuffer; VAR pos: LONGINT);
CONST
   maxWordSize = 32;
TYPE
   String = POINTER TO ARRAY maxWordSize OF CHAR;
VAR
   i, j: LONGINT;
   key: SimpleHash.ItemKey;
   word: String;
   c: CHAR;     
BEGIN
   i := 0; j := 0; NEW(key, maxWordSize);
   WHILE j < pos DO
      c := buffer[j];
      CASE c OF
         | "A".."Z" : buffer[j] := CHR(ORD(c)+32); INC(j);      
         | "a".."z" : INC(j);
      ELSE
         IF j > i THEN                        
            buffer[j] := 0X;	
            word := S.VAL(String, S.ADR(buffer[i]));		    		
            COPY(word^, key^);         
         
            item := SimpleHash.AddKey(wordCounts, key);
            INC(item.value, 1);         
                 
            IF item.value = 1 THEN NEW(key, maxWordSize); END;		
         END;
         INC(j); i := j;	                          
      END;   
   END;   
   IF j > i THEN pos := i; END; (* indicate buffer position *)
END CountWords;   
   

PROCEDURE QuicksortItems (n: LONGINT; VAR a: ARRAY OF SimpleHash.Item);

   PROCEDURE Swap(i, j: LONGINT);
   VAR t: SimpleHash.Item;
   BEGIN
      t := a[i]; a[i] := a[j]; a[j] := t;
   END Swap;

   PROCEDURE Sort(l, r: LONGINT);
   VAR
      i, j: LONGINT;
      pivot: SimpleHash.Item;
   BEGIN
      i := l;
      j := r;
      pivot := a[(l+r) DIV 2];
      REPEAT          
         WHILE (a[i].value > pivot.value) OR
            ((a[i].value = pivot.value) &
	      (a[i].key^ > pivot.key^)) DO INC(i); END;
         WHILE (pivot.value > a[j].value) OR
            ((pivot.value = a[j].value) &
	      (pivot.key^ > a[j].key^)) DO DEC(j); END;   
   	
         IF i <= j THEN Swap(i, j); INC(i); DEC(j); END;
      UNTIL i > j;
      IF l < j THEN Sort(l, j); END;
      IF r > i THEN Sort(i, r); END;
   END Sort;
   
BEGIN
   Sort(0, n-1);
END QuicksortItems;


BEGIN  
   wordCounts := SimpleHash.New(4000);
   FillAndProcess(buffer, CountWords);    
      
   size := SimpleHash.Count(wordCounts);
   NEW(items, size);
   item := SimpleHash.First(wordCounts);
   i := 0;
   WHILE item # NIL DO
      items[i] := item;
      item := SimpleHash.Next(wordCounts);
      INC(i);
   END;

   QuicksortItems(size, items^);

   FOR i := 0 TO size - 1 DO
      Out.Int(items[i].value,7); Out.Char(' ');
      Out.String(items[i].key^); Out.Ln;
   END;
END wordfreq.