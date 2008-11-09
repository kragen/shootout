% The Computer Language Benchmarks Game                        
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import Application Open

define
   proc {Mandelbrot F Side}
      IXMax = Side - 1
      IYMax = IXMax
      XMax = {IntToFloat Side}
      YMax = XMax
      M = 50
      Limit2 = 4.0


      proc {XLoop IX Y B N}
         X = {IntToFloat IX}
         Cr = 2.0*X / XMax - 1.5
         Ci = 2.0*Y / YMax - 1.0
         Bits
         Bitnum
    
         fun {Include J Zr Zi Tr Ti}
            if J<M andthen Tr + Ti =< Limit2 then 
               I = 2.0 * Zr * Zi + Ci
               R = Tr - Ti + Cr
            in
               {Include J+1 R I R*R I*I}
            else 
               Tr + Ti =< Limit2
            end
         end

      in
         if IX =< IXMax then
            Bits = if {Include 0 0.0 0.0 0.0 0.0} then B*2+1 else B*2 end
            Bitnum = N+1 

            if Bitnum == 8 then 
               {F putC(Bits)}
               {XLoop IX+1 Y 0 0}
            elseif IX == IXMax then
               {F putC( Bits * {Pow 2 (8 - (Side mod 8))} )}
               {XLoop IX+1 Y 0 0}
            else
               {XLoop IX+1 Y Bits Bitnum}
            end
         end
      end


      proc {YLoop IY}
         if IY =< IYMax then
            {XLoop 0 {IntToFloat IY} 0 0} 
            {YLoop IY+1}
         end
      end

   in
      {F putS("P4")}
      {F putS({IntToString Side} # " " # {IntToString Side})}
      {YLoop 0}
   end


   [Arg] = {Application.getArgs plain}
   N = {String.toInt Arg}

   class TextFile from Open.file Open.text end
   StdOut = {New TextFile init(name:stdout)}

in      
   {Mandelbrot StdOut N}
   {Application.exit 0}   
end
