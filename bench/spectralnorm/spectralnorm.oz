% ----------------------------------------------------------------------
% The Great Computer Language Shootout                              
% http://shootout.alioth.debian.org/                                
%                                                                   
% Floating point conversion routines courtesy Juergen Stuber and Jorge
% Marques Pelizzoni [previously used in other Mozart/Oz Shooutout
% submissions].
%                                                                   
% Contributed by Anthony Borla
% ----------------------------------------------------------------------

functor

import
  System(showInfo show) Application(exit getArgs)

define
  fun {Approximate N}
    U = {NewArray 1 N 1.0} V = {NewArray 1 N 0.0} VBv = {NewCell 0.0} Vv = {NewCell 0.0}
  in
    for I in 1..10 do
      {MulAtAv N U V} {MulAtAv N V U}
    end

    for I in 1..{Array.high U} do
      VBv := @VBv + {Array.get U I} * {Array.get V I}
      Vv := @Vv + {Array.get V I} * {Array.get V I}
    end

    {Float.sqrt (@VBv / @Vv)}
  end

  fun {A I J}
    If = {IntToFloat (I - 1)} Jf = {IntToFloat (J - 1)}
  in
    1.0 / ((If + Jf) *( If + Jf + 1.0) / 2.0 + If + 1.0)
  end

  proc {MulAv N V Av}
    for I in 1..N do
      {Array.put Av I 0.0}
      for J in 1..N do
        {Array.put Av I ({Array.get Av I} + {A I J} * {Array.get V J})}  
      end
    end
  end

  proc {MulAtv N V Atv}
    for I in 1..N do
      {Array.put Atv I 0.0}
      for J in 1..N do
        {Array.put Atv I ({Array.get Atv I} + {A J I} * {Array.get V J})}
      end
    end
  end

  proc {MulAtAv N V AtAv}
    U = {NewArray 1 N 0.0}
  in
    {MulAv N V U} {MulAtv N U AtAv}
  end

  fun {CmdlNArg Nth Default} N Nt in
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

  N 

in
  N = {CmdlNArg 1 100}

  {System.showInfo {FloatToString {Approximate N} 9}}  

  {Application.exit 0}
end

