% The Computer Language Shootout                              
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy
% based on Greg Buchholz's C program

functor
import Application Open

define

   class MandelbrotWriter
      attr side zr zi cr ci tr ti bits:0 bitnum:0 

      meth init(X)
         side := X
      end

      meth write(F)
         M = 50
         Limit2 = 4.0 
         IYMax = @side - 1 
         IXMax = IYMax
         YMax = {IntToFloat @side}
         XMax = YMax
      in 
         {F putS("P4")}
         {F putS({IntToString @side} # " " # {IntToString @side})}
         
         for IY in 0..IYMax do 
            Y = {IntToFloat IY} 
         in
            for IX in 0..IXMax do 
               X = {IntToFloat IX} 
            in
               zr := 0.0 
               zi := 0.0
               tr := 0.0 
               ti := 0.0
               cr := 2.0*X / XMax - 1.5
               ci := 2.0*Y / YMax - 1.0

               for I in 0; I<M andthen @tr + @ti =< Limit2; I+1 do 
                  zi := 2.0 * @zr * @zi + @ci
                  zr := @tr - @ti + @cr
                  tr := @zr*@zr
                  ti :=  @zi*@zi
               end

               bits := @bits * 2
               if @tr + @ti =< Limit2 then bits := @bits + 1 end

               bitnum := @bitnum + 1

               if @bitnum == 8 then 
                  {F putC(@bits)}
                  bits := 0 bitnum := 0
               elseif IX == IXMax then
                  bits := @bits * {Pow 2 (8 - (@side mod 8))}
                  {F putC(@bits)}
                  bits := 0 bitnum := 0
               end
            end        
         end
      end   % write

   end   % MandelbrotWriter

   class TextFile from Open.file Open.text end


   [Arg] = {Application.getArgs plain}
   N = {String.toInt Arg}

   Mandelbrot = {New MandelbrotWriter init(N)}
   StdOut = {New TextFile init(name:stdout)}

in      
   {Mandelbrot write(StdOut)}
   {StdOut close}
   {Application.exit 0}   
end
