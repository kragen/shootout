(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   contributed by Isaac Gouy (Oberon-2 novice)
*)

MODULE except;
IMPORT Shootout, Exception, Out;
 
TYPE   
   LoException = POINTER TO LoExceptionDesc;
   LoExceptionDesc = RECORD (Exception.UncheckedDesc) END; 
   
   HiException = POINTER TO HiExceptionDesc;
   HiExceptionDesc = RECORD (Exception.UncheckedDesc) END;  
                
VAR
   n, i, loCount, hiCount: LONGINT;
   lo: LoException; 
   hi: HiException;   
             
PROCEDURE Blowup(n: LONGINT);             
BEGIN
   IF ODD(n) THEN RAISE(hi); ELSE RAISE(lo); END;
END Blowup;              
             
PROCEDURE LoProc(n: LONGINT);             
BEGIN
   TRY Blowup(n); CATCH LoException: INC(loCount); END;
END LoProc; 

PROCEDURE HiProc(n: LONGINT);             
BEGIN
   TRY LoProc(n); CATCH HiException: INC(hiCount); END;
END HiProc;     

PROCEDURE SomeProc(n: LONGINT);             
BEGIN
   TRY HiProc(n); 
   CATCH Exception.Unchecked: 
      Out.String("We shouldn't get here!"); Out.Ln;
   END;
END SomeProc;       
                          
BEGIN    
   n := Shootout.Argi(); NEW(lo); NEW(hi);
   FOR i := 1 TO n DO SomeProc(i); END;
   Out.String("Exceptions: HI="); Out.Int(hiCount, 0);
   Out.String(" / LO="); Out.Int(loCount, 0); Out.Ln;
END except. 