% The Computer Language Benchmarks Game                               
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy
% based on Andrei Formiga's functional Scala program

functor
import Application System

define
   fun {Flips A}
      Last = A.1
   in
      if Last == 1 then 0
      else
         for I in 1..Last div 2 do
            From = Last + 1 - I
            Swap = A.I       
         in
            A.I := A.From
            A.From := Swap
         end

         {Flips A} + 1
      end
   end


   proc {ShowPermutation A}
      for I in 1..{Array.high A} do {System.printInfo A.I} end
      {System.showInfo ""}
   end

   proc {FlipPermutation A}
      Count = {Flips {Array.clone A}}
   in       
      if Count > @MaxFlipsCount then MaxFlipsCount := Count end
      if @Check < 30 then {ShowPermutation A} Check := @Check + 1 end
   end


   proc {RotateLeft ?A N}
      Swap = A.1
   in
      for I in 1..N-1 do A.I := A.(I+1) end
      A.N := Swap
   end

   proc {Permutations A N J}
      if J < N then 
         if N == 1 then 
            {FlipPermutation A} 
         else
            {Permutations A N-1 0}
            {RotateLeft A N}
            {Permutations A N J+1}
         end
      end
   end


   [Arg] = {Application.getArgs plain}
   N = {String.toInt Arg}

   fun {Numbers N} 
      A = {NewArray 1 N 0}
   in
      for I in 1..N do A.I := I end
      A
   end

   MaxFlipsCount = {NewCell 0}
   Check = {NewCell 0}

in    
   {Permutations {Numbers N} N 0}
   {System.showInfo "Pfannkuchen(" # N # ") = " # @MaxFlipsCount}
   {Application.exit 0}   
end

