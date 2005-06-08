(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   contributed by Isaac Gouy (Oberon-2 novice)
*)

MODULE spellcheck;
IMPORT IO, IO:StdChannels, S:=SYSTEM, SimpleHash, In, Out, Files, TextRider;

CONST
   maxWordSize = 32;
   readSize = 4096;   
   
TYPE
   FixedBuffer = ARRAY readSize OF CHAR;
   FixedBufferProc = PROCEDURE (VAR b: FixedBuffer; VAR pos: LONGINT); 
   WordString = ARRAY maxWordSize OF CHAR;   

VAR
   buffer: FixedBuffer;
   word: WordString;
   result: Files.Result;
   f: Files.File;
   dictionary: SimpleHash.Hashtable;
   key: SimpleHash.ItemKey;
   item: SimpleHash.Item;


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


PROCEDURE CheckWords(VAR buffer: FixedBuffer; VAR pos: LONGINT);
TYPE
   WordStringPtr = POINTER TO WordString;
VAR
   i, j: LONGINT;
   bufferWord: WordStringPtr;
BEGIN
   i := 0; j := 0; NEW(key, maxWordSize);
   WHILE j < pos DO	
      IF buffer[j] = 0AX THEN
         buffer[j] := 0X;	
         bufferWord := S.VAL(WordStringPtr, S.ADR(buffer[i]));	         	    		
         COPY(bufferWord^, key^);
	
         IF SimpleHash.Find(dictionary, key) = NIL THEN
            Out.String(key^); Out.Ln;
         END;	
	 	
         INC(j); i := j;	
      ELSE
         INC(j);
      END;
   END;
      
   IF j > i THEN pos := i; END; (* indicate buffer position *)
END CheckWords;


BEGIN
   f := Files.Old("Usr.Dict.Words", {Files.read}, result);
   IF result # Files.done THEN
      Out.String("Usr.Dict.Words not opened"); Out.Ln; HALT(1);
   END;   

   dictionary := SimpleHash.New(40000);	
   In.SetReader( TextRider.ConnectReader(f) );
   LOOP	
      In.Line(word);
      IF ~In.Done() THEN EXIT; END;
      
      NEW(key, maxWordSize);
      COPY(word,key^);         
      item := SimpleHash.AddKey(dictionary, key);	
   END;     
   f.Close();

   FillAndProcess(buffer, CheckWords);      
END spellcheck.