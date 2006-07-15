% The Computer Language Shootout                              
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import 
   Application System
   S at '../../Include/oz/shootout.ozf'

define
   fun {Fib One Two}
      F = fun {$ N} 
         if N < Two then One 
         else {F N-One} + {F N-Two} end 
      end
   in F end

   fun {Tak One}
      F = fun {$ X Y Z}
         if Y < X then {F {F X-One Y Z} {F Y-One Z X} {F Z-One X Y}}
         else Z end
      end
   in F end

   FibI = {Fib 1   2  }
   FibF = {Fib 1.0 2.0}
   TakI = {Tak 1  }
   TakF = {Tak 1.0}

   fun {AckI M N}
      if M == 0 then N + 1 
      elseif N == 0 then {AckI M-1 1} 
      else {AckI M-1 {AckI M N-1}} end 
   end

   [Arg] = {Application.getArgs plain}
   N = {String.toInt Arg}
   M = N-1
   A = 27.0 + {IntToFloat N}

   Prefix1 = "Fib(" # {S.floatToString A 1} # "): "
   Prefix2 = "Tak(" # 3*M # "," # 2*M # "," # M # "): "
in
   {System.showInfo "Ack(3," # N # "): " # {AckI 3 N}}
   {System.showInfo Prefix1 # {S.floatToString {FibF A} 1} }
   {System.showInfo Prefix2 # {TakI 3*M 2*M 1*M}}
   {System.showInfo "Fib(3): " # {FibI 3}}
   {System.showInfo "Tak(3.0,2.0,1.0): " # {S.floatToString {TakF 3.0 2.0 1.0} 1} }
   {Application.exit 0}   
end
