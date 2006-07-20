% ----------------------------------------------------------------------
% The Computer Language Shootout                              
% http://shootout.alioth.debian.org/
% Contributed by Anthony Borla
% modified by Isaac Gouy
% ----------------------------------------------------------------------

functor

import
  System(showInfo) Application(exit getArgs)
   S at '../../Include/oz/shootout.ozf'

define



  fun {Ack X Y}
    if X == 0 then Y + 1
    elseif Y == 0 then {Ack (X - 1) 1}
    else {Ack (X - 1) {Ack X (Y - 1)}}
    end
  end



  fun {Fib N}
    if N < 2 then 1
    else {Fib (N - 2)} + {Fib (N - 1)}
    end
  end



  fun {FibFlt N}
    if N < 2.0 then 1.0
    else {FibFlt (N - 2.0)} + {FibFlt (N - 1.0)}
    end
  end



  fun {Tak X Y Z}
    if Y < X then {Tak {Tak (X - 1) Y Z} {Tak (Y - 1) Z X} {Tak (Z - 1) X Y}}
    else Z
    end
  end



  fun {TakFlt X Y Z}
    if Y < X then {TakFlt {TakFlt (X - 1.0) Y Z} {TakFlt (Y - 1.0) Z X} {TakFlt (Z - 1.0) X Y}}
    else Z
    end
  end



  fun {CmdlNArg Nth Default}
    N Nt in
    try
      Nt = {String.toInt {Application.getArgs plain}.Nth}
      N = if Nt < Default then Default else Nt end
    catch error(...) then
      N = Default
    end
    N
  end


  N NFlt NAdj


in
  N = {CmdlNArg 1 1} NFlt = {Int.toFloat N} NAdj = N - 1

  {System.showInfo "Ack(3," # N # "): " # {Ack 3 N}}
  {System.showInfo "Fib(" # (27.0 + NFlt) # "): " # {S.floatToString {FibFlt (27.0 + NFlt)} 1}}

  {System.showInfo "Tak(" # NAdj * 3 # "," # NAdj * 2 # "," # NAdj # "): " # {Tak (NAdj * 3) (NAdj * 2) NAdj}}

  {System.showInfo "Fib(3): " # {Fib 3}}
  {System.showInfo "Tak(3.0,2.0,1.0): " # {S.floatToString {TakFlt 3.0 2.0 1.0} 1}}

  {Application.exit 0}
end

