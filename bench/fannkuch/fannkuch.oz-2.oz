% The Computer Language Shootout                              
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import
   System Application 

define
   fun {Fannkuch N} 
      local
         M = N-1 
         R = {NewCell N}
         Check = {NewCell 0}
         Perm = {NewArray 0 M 0}
         Perm1 = {NewArray 0 M 0}
         Count = {NewArray 0 M 0}
         MaxPerm = {NewArray 0 M 0}
         FlipsCount = {NewCell 0}
         MaxFlipsCount = {NewCell 0} 
         Done = {NewCell false}
      in

         for I in 0..M do Perm1.I := I end

         for break:B do
   
            % show we're working with the same sequence of permutations
            if @Check<30 then
               for I in 0..M do {System.print Perm1.I + 1} end
               {System.printInfo "\n"}
               Check := @Check + 1
            end

            for while: @R \= 1 do 
               Count.(@R-1) := @R 
               R := @R - 1 
            end

            if {Not Perm1.0 == 0 orelse Perm1.M == M} then
               for I in 0..M do Perm.I := Perm1.I end
               FlipsCount := 0

               for break:B do
                  local K = Perm.0 in
                     if K == 0 then {B} end   % break loop

                     for I in 0..((K+1) div 2 - 1) do 
                        local Swap = Perm.I in
                           Perm.I := Perm.(K-I)
                           Perm.(K-I) := Swap
                        end
                     end
                     FlipsCount := @FlipsCount + 1
                  end
               end
               if @FlipsCount > @MaxFlipsCount then
                  MaxFlipsCount := @FlipsCount
                  for I in 0..M do MaxPerm.I := Perm1.I end
               end
            end

            for break:B do
               if @R == N then Done := true {B} end   % return from function
               
               local Perm0 = Perm1.0 I = {NewCell 0} K = {NewCell 0} in
                  for while: @I < @R do 
                     K := @I + 1
                     Perm1.@I := Perm1.@K 
                     I := @K 
                  end
                  Perm1.@R := Perm0
               end
               
               Count.@R := Count.@R - 1
               if Count.@R > 0 then {B} end   % break loop

               R := @R + 1
            end

            if @Done then {B} end

         end      
         @MaxFlipsCount   

      end
   end


   [Arg] = {Application.getArgs plain}
   N = {String.toInt Arg}

in   
   {System.showInfo "Pfannkuchen(" # {IntToString N} # ") = " # 
      {IntToString {Fannkuch N}} }
   {Application.exit 0}   
end
