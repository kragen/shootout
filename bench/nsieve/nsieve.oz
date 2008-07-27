% The Computer Language Benchmarks Game                             
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import System Application 

define
   fun {NSieve N ?IsPrime} 
      Count = {NewCell 0} 
   in
      for I in 2..N do IsPrime.I := true end

      for I in 2..N do 
         if IsPrime.I then
            Count := @Count + 1
            for K in I+I; K=<N; K+I do IsPrime.K := false end              
         end
      end
      @Count
   end


   proc {Line N A}
      S = "Primes up to " N1 = N*10000 in
         {System.showInfo S # {Pad N1 8} # " " # {Pad {NSieve N1 A} 8} }
   end

   fun {Pad I W} 
      S = {NewCell {IntToString I}}
      L = W - {Length @S}
   in
      for I in 1..L do S := {Append " " @S} end
      @S
   end

   [Arg] = {Application.getArgs plain}
   N = {String.toInt Arg}

   BooleanArray = {NewArray 0 ({Pow 2 N  }*10000)+1 true}

in   
   {Line {Pow 2 N  } BooleanArray}
   {Line {Pow 2 N-1} BooleanArray}
   {Line {Pow 2 N-2} BooleanArray}
   {Application.exit 0}   
end

