(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   contributed by Isaac Gouy (Oberon-2 novice)

   To run:   Mandelbrot 200
*)


MODULE mandelbrot;
IMPORT Shootout, Out;

CONST
   m = 50;
   limit2 = 4.0;

VAR
   width, height, y, x, i, bits, bitnum: LONGINT;
   isOverLimit: BOOLEAN;
   Zr, Zi, Cr, Ci, Tr, Ti: LONGREAL;

BEGIN
   width := Shootout.Argi();
   height := width;

   Out.String("P4"); Out.Ln;
   Out.Int(width,0); Out.Char(20X); Out.Int(width,0); Out.Ln;

   FOR y := 0 TO height-1 DO
      FOR x := 0 TO width-1 DO
         Zr := 0.0; Zi := 0.0;
         Cr := 2.0 * x / width - 1.5;
         Ci := 2.0 * y / height - 1.0;

         i := 0;
         REPEAT
            Tr := Zr*Zr - Zi*Zi + Cr;
            Ti := 2*Zr*Zi + Ci;
            Zr := Tr; Zi := Ti;
            INC(i);
            isOverLimit := Zr*Zr + Zi*Zi > limit2;
         UNTIL isOverLimit OR (i = m);
	
         bits := ASH(bits,1);
         IF ~isOverLimit THEN INC(bits); END;
         INC(bitnum);

         IF x = width - 1 THEN
            bits := ASH(bits,8-bitnum); bitnum := 8;	
         END;

         IF bitnum = 8 THEN
            Out.Char(CHR(bits)); bits := 0; bitnum := 0;	
         END;		
      END;
   END;
END mandelbrot.
