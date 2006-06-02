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
  System(showInfo) Application(exit getArgs)

define

% ------------- %

  local
    A1 = {NewCell 0.0} A2 = {NewCell 0.0} A3 = {NewCell 0.0}
    A4 = {NewCell 0.0} A5 = {NewCell 0.0} A6 = {NewCell 0.0}
    A7 = {NewCell 0.0} A8 = {NewCell 0.0} A9 = {NewCell 0.0}

    TwoThirds = 2.0 / 3.0

    % ------------- %

    proc {ComputeSums_ D N ALT}
      if {FloatToInt D} > N then
        skip
      else D2 D3 DS DC in
        D2 = D * D   D3 = D2 * D
        DS = {Sin D} DC = {Cos D}

        A1 := @A1 + {Pow TwoThirds (D - 1.0)}
        A2 := @A2 + 1.0 / {Sqrt D}
        A3 := @A3 + 1.0 / (D * (D + 1.0))
        A4 := @A4 + 1.0 / (D3 * DS * DS)
        A5 := @A5 + 1.0 / (D3 * DC * DC)
        A6 := @A6 + 1.0 / D
        A7 := @A7 + 1.0 / (D2)
        A8 := @A8 + ALT / D
        A9 := @A9 + ALT / (2.0 * D - 1.0)

        {ComputeSums_ (D + 1.0) N ~(ALT)}
      end
    end

  in
    proc {ComputeSums N}
      A1 := 0.0 A2 := 0.0 A3 := 0.0 A4 := 0.0 A5 := 0.0 A6 := 0.0
      A7 := 0.0 A8 := 0.0 A9 := 0.0
      {ComputeSums_ 1.0 N 1.0}    
    end

    % ------------- %

    proc {ShowSums}
      {System.showInfo {FloatToString @A1 9} # "\t(2/3)^k"}
      {System.showInfo {FloatToString @A2 9} # "\tk^-0.5"}
      {System.showInfo {FloatToString @A3 9} # "\t1/k(k+1)"}
      {System.showInfo {FloatToString @A4 9} # "\tFlint Hills"}
      {System.showInfo {FloatToString @A5 9} # "\tCookson Hills"}
      {System.showInfo {FloatToString @A6 9} # "\tHarmonic"}
      {System.showInfo {FloatToString @A7 9} # "\tRiemann Zeta"}
      {System.showInfo {FloatToString @A8 9} # "\tAlternating Harmonic"}
      {System.showInfo {FloatToString @A9 9} # "\tGregory"}
    end
  end

% ------------- %

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

% ------------- %

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
      elseif Prec > 10 then raise excessivePrecision(Prec) end
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
    Result = {NewCell {VirtualString.toString {FloatToVS F Prec}}}
    P = fun {$ C} if C == &~ then &- else C end end
  in
    if F < 0.0 andthen {Nth @Result 1} \= &~ then
      Result := &~|@Result 
    end
    {Map @Result P}
  end

% ------------- %

  N

% ------------- %

in
  N = {CmdlNArg 1 1}

  {ComputeSums N}
  {ShowSums}

  {Application.exit 0}
end

