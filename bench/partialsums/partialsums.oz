% ----------------------------------------------------------------------
% The Great Computer Language Shootout                              
% http://shootout.alioth.debian.org/                                
%                                                                   
% Code based on Prolog language implementation by Anthony Borla
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

define
  N A1_ A2_ A3_ A4_ A5_ A6_ A7_ A8_ A9_

  proc {ComputeSums N}
    A1_ = {NewCell 0.0} A2_ = {NewCell 0.0} A3_ = {NewCell 0.0}
    A4_ = {NewCell 0.0} A5_ = {NewCell 0.0} A6_ = {NewCell 0.0}
    A7_ = {NewCell 0.0} A8_ = {NewCell 0.0} A9_ = {NewCell 0.0}

    {ComputeSums_ 1.0 N 1.0}    
  end

  proc {ComputeSums_ D N ALT}
    if {FloatToInt D} > N then
      skip
    else
      local D2 D3 DS DC in
        D2 = D * D        D3 = D2 * D
        DS = {Sin D} DC = {Cos D}

        A1_ := @A1_ + {Pow (2.0 / 3.0) (D - 1.0)}
        A2_ := @A2_ + 1.0 / {Sqrt D}
        A3_ := @A3_ + 1.0 / (D * (D + 1.0))
        A4_ := @A4_ + 1.0 / (D3 * DS * DS)
        A5_ := @A5_ + 1.0 / (D3 * DC * DC)
        A6_ := @A6_ + 1.0 / D
        A7_ := @A7_ + 1.0 / (D2)
        A8_ := @A8_ + ALT / D
        A9_ := @A9_ + ALT / (2.0 * D - 1.0)
      end 

      {ComputeSums_ (D + 1.0) N ~(ALT)}
    end
  end

  proc {ShowSums}
    {System.showInfo {FloatToString @A1_ 9} # "\t(2/3)^k"}
    {System.showInfo {FloatToString @A2_ 9} # "\tk^-0.5"}
    {System.showInfo {FloatToString @A3_ 9} # "\t1/k(k+1)"}
    {System.showInfo {FloatToString @A4_ 9} # "\tFlint Hills"}
    {System.showInfo {FloatToString @A5_ 9} # "\tCookson Hills"}
    {System.showInfo {FloatToString @A6_ 9} # "\tHarmonic"}
    {System.showInfo {FloatToString @A7_ 9} # "\tRiemann Zeta"}
    {System.showInfo {FloatToString @A8_ 9} # "\tAlternating Harmonic"}
    {System.showInfo {FloatToString @A9_ 9} # "\tGregory"}
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
  N = {CmdlNArg 1 1}

  {ComputeSums N}
  {ShowSums}

  {Application.exit 0}
end

