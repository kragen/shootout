%% The Computer Language Benchmarks Game                              
%% http://shootout.alioth.debian.org/  
%% contributed by Isaac Gouy

functor
export 
   FloatToString

define

   fun {NSign X}
      if X<0.0 then "-" else "" end
   end

   fun {NDigits X0 Z I S0 Exp}
      if X0<Z then
         S0 # Exp
      else  
         local X S in 
            X = (X0-I)*10.0
            if Exp == ~1 then S = S0#"." else S = S0 end
            {NDigits X Z*10.0 {Floor X} S#{IntToString {FloatToInt I}} Exp-1}
         end
      end
   end

   fun {NZeros S Exp N Point}
      if Exp<~N then
         S
      else
         if Exp==~1 andthen Point then
            {NZeros S#"." Exp N false}
         else
            {NZeros S#"0" Exp-1 N Point}
         end
      end
   end

   fun {FloatToString F N}
      local 
         Z = {Pow 10.0 ~{IntToFloat N}}
         X = 0.5*Z + {Abs F}
         T = {NDigits X Z {Floor X} {NSign F} 0}
      in
         {NZeros T.1 T.2 N true}              
      end
   end

end
