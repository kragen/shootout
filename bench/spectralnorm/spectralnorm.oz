% The Computer Language Benchmarks Game                              
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import
   System Application 
   S at 'Include/oz/shootout.ozf'  

define
   [Arg] = {Application.getArgs plain}
   N = {String.toInt Arg}
   M = N-1

   % return element i,j of infinite matrix A
   fun {A I J} 1.0 / {IntToFloat (I+J)*(I+J+1) div 2 + I+1} end

   % multiply vector v by matrix A
   proc {MultiplyAv V ?Av}
      for I in 0..M do
         Av.I := 0.0
         for J in 0..M do 
            Av.I := Av.I + {A I J}*V.J
         end
      end
   end

   % multiply vector v by matrix A transposed
   proc {MultiplyAtv V ?Atv}
      for I in 0..M do
         Atv.I := 0.0 
         for J in 0..M do 
            Atv.I := Atv.I + {A J I}*V.J
         end
      end
   end

   % multiply vector v by matrix A and then by matrix A transposed
   proc {MultiplyAtAv V ?AtAv}
      U = {NewArray 0 M 0.0} 
   in 
      {MultiplyAv V U}
      {MultiplyAtv U AtAv}
   end

   U = {NewArray 0 M 1.0}
   V = {NewArray 0 M 0.0}

   Vbv = {NewCell 0.0}
   Vv = {NewCell 0.0}

in   
   % 20 steps of the power method
   for I in 1..10 do 
      {MultiplyAtAv U V}
      {MultiplyAtAv V U}
   end

   for I in 0..M do 
      Vbv := @Vbv + U.I*V.I 
      Vv := @Vv + V.I*V.I 
   end

   {System.showInfo {S.floatToString {Sqrt @Vbv/@Vv} 9}}
   {Application.exit 0}   
end
