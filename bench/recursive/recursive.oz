% ----------------------------------------------------------------------
% The Great Computer Language Shootout                              
% http://shootout.alioth.debian.org/                                
%                                                                   
% Code based on / inspired by existing, relevant Shootout submissions
%
% Floating point conversion routines courtesy Juergen Stuber and Jorge
% Marques Pelizzoni [previously used in other Mozart/Oz Shooutout
% submissions].
%
% Contributed by Anthony Borla
% ----------------------------------------------------------------------

functor

import
  System Application

define N NFlt NAdj
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

  %% Floating Point Conversion Routines
  fun {FloatAbs X}
    if X >= 0.0 then X else ~X end
  end

  fun {FloatSquare X}
    X * X
  end

  fun {FloatPower X E}
    if E==0 then 1.0
    elseif E<0 then raise negativeExponent(E) end
    else
      if E mod 2 == 1 then X else 1.0 end
      * {FloatSquare {FloatPower X E div 2}}
    end
  end

  fun {MakePadding Ch L}
    if L > 0 then
      Padding = {MakeList L}
    in
      for V in Padding do V = Ch end
        Padding
      else
        nil
    end
  end

  fun {PadLeft Ch String L}
    PL = L - {List.length String}
  in
    {MakePadding Ch PL} # String
  end

  fun {FloatToVS F Prec}
    fun {FractionToString Frac Prec}
      if Prec =< 0 then ""
      elseif Prec > 9 then raise excessivePrecision(Prec) end
      else
        Shifted = {FloatPower 10.0 Prec} * Frac
        Digits = {FloatToInt {Round Shifted}}
        in {PadLeft &0 {IntToString Digits} Prec}
      end
    end

    I = {FloatToInt {if F >= 0.0 then Floor else Ceil end F}}
    Frac = {FloatAbs F - {IntToFloat I}}
  in
    {IntToString I} # "." # {FractionToString Frac Prec}
  end

  fun {FloatToString F Prec}
    P = fun {$ C} if C == &~ then &- else C end end
    in
    {Map {VirtualString.toString {FloatToVS F Prec}} P}
  end

in
  N = {CmdlNArg 1 1} NFlt = {Int.toFloat N} NAdj = N - 1

  {System.showInfo "Ack(3," # N # "): " # {Ack 3 N}}
  {System.showInfo "Fib(" # (27.0 + NFlt) # "): " # {FloatToString {FibFlt (27.0 + NFlt)} 1}}

  {System.showInfo "Tak(" # NAdj * 3 # "," # NAdj * 2 # "," # NAdj # "): " # {Tak (NAdj * 3) (NAdj * 2) NAdj}}

  {System.showInfo "Fib(3): " # {Fib 3}}
  {System.showInfo "Tak(3.0,2.0,1.0): " # {FloatToString {TakFlt 3.0 2.0 1.0} 1}}

  {Application.exit 0}
end

