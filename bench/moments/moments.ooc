(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   contributed by Isaac Gouy (Oberon-2 novice)
*)


MODULE moments;
IMPORT IO, IO:StdChannels, S:=SYSTEM, RealConv, Out, LRealMath;

CONST
   readSize = 4096;

TYPE
   FixedBuffer = ARRAY readSize OF CHAR;
   FixedBufferProc = PROCEDURE (VAR b: FixedBuffer; VAR pos: LONGINT);   
   Reals = POINTER TO ARRAY OF REAL;

VAR
   buffer: FixedBuffer;
   x: Reals;
   i, n, mid: LONGINT;
   sum, mean, dev, adev, dev2, var, skew, kurt, sdev, median: LONGREAL;


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


PROCEDURE ReadReals(VAR buffer: FixedBuffer; VAR pos: LONGINT);
TYPE
   Chars = POINTER TO ARRAY 32 OF CHAR;
VAR
   i, j: LONGINT;
   chars: Chars;
   tmp: Reals;
BEGIN
   i := 0; j := 0; 
   WHILE j < pos DO	
      IF buffer[j] = 0AX THEN
            
         IF n = LEN(x^) THEN (* increase array size *)
            NEW(tmp, ASH(LEN(x^),1));
            S.MOVE(S.ADR(x[0]), S.ADR(tmp[0]), n*SIZE(REAL));            
            x := tmp; tmp := NIL;
         END;            
            
         buffer[j] := 0X;	       
         chars := S.VAL(Chars, S.ADR(buffer[i]));           
         x[n] := RealConv.ValueReal(chars^);                          
         sum := sum + x[n]; INC(n);         
         
         INC(j); i := j;	
      ELSE
         INC(j);
      END;                  
   END;         
      
   IF j > i THEN pos := i; END; (* indicate buffer position *)
END ReadReals; 


PROCEDURE QuickSelect(n: LONGINT; VAR a: ARRAY OF REAL): REAL; 
VAR
   lo, hi, median, mid, l, h: LONGINT;
   t: REAL;
   
PROCEDURE Swap(i,j: LONGINT); BEGIN t := a[i]; a[i] := a[j]; a[j] := t; END Swap;  
   
BEGIN
   lo := 0; hi := n-1; median := (lo + hi) DIV 2;
   LOOP
      IF hi <= lo THEN RETURN a[median]; END;
      IF hi = lo + 1 THEN 
         IF a[lo] > a[hi] THEN Swap(lo,hi); END;
         RETURN a[median];
      END;      
   
      mid := (lo + hi) DIV 2;
      IF a[mid] > a[hi] THEN Swap(mid,hi); END;
      IF a[lo] > a[hi] THEN Swap(lo,hi); END;  
      IF a[mid] > a[lo] THEN Swap(mid,lo); END;
      
      Swap(mid,lo+1);       
      
      l := lo + 1; h := hi;     
      LOOP  
         REPEAT INC(l); UNTIL a[lo] <= a[l];
         REPEAT DEC(h); UNTIL a[h] <= a[lo]; 
         IF h < l THEN EXIT; END; 
         Swap(l,h);         
      END;       
      
      Swap(lo,h);
      IF h <= median THEN lo := l; END;
      IF h >= median THEN hi := h - 1; END; 
   END;     
END QuickSelect; 


BEGIN
   n := 0; sum := 0.0; NEW(x,4096);
   FillAndProcess(buffer, ReadReals);  
   
   mean := sum / n;
   FOR i := 0 TO n-1 DO
      dev := x[i] - mean;
      adev := adev + ABS(dev);
      dev2 := dev * dev;
      var := var + dev2;
      skew := skew + dev2 * dev;
      kurt := kurt + dev2 * dev2;
   END;
   adev := adev / n;
   var := var / (n - 1);
   sdev := LRealMath.sqrt(var);
   IF var # 0.0 THEN
      skew := skew / (n * var * sdev);
      kurt := kurt / (n * var * var) - 3.0;
   END;

   median := QuickSelect(n, x^);   
   mid := (n DIV 2) - 1;
   IF ODD(mid) THEN median := (x[mid] + x[mid+1]) / 2; END;    
               
   Out.String("n:                  "); Out.Int(n,0); Out.Ln;
   Out.String("median:             "); Out.LongRealFix(median,0,6); Out.Ln;
   Out.String("mean:               "); Out.LongRealFix(mean,0,6); Out.Ln;
   Out.String("average_deviation:  "); Out.LongRealFix(adev,0,6); Out.Ln;
   Out.String("standard_deviation: "); Out.LongRealFix(sdev,0,6); Out.Ln;
   Out.String("variance:           "); Out.LongRealFix(var,0,6); Out.Ln;
   Out.String("skew:               "); Out.LongRealFix(skew,0,6); Out.Ln;
   Out.String("kurtosis:           "); Out.LongRealFix(kurt,0,6); Out.Ln; 
END moments.


