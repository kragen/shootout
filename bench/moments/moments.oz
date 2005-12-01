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
  System(showInfo) Application(exit) Open(file text)

define
  N_ MEDIAN_ MEAN_ AVGDEV_ STDDEV_ VARIANCE_ SKEW_ KURTOSIS_

  class TextFile
    from Open.file Open.text
  end

  fun {LoadData FILE}
    case {FILE getS($)} of false then
      nil
    elseof DATUM then
      {Int.toFloat {String.toInt {Filter DATUM fun {$ C} C \= 13 end}}}|{LoadData FILE}
    end
  end

  proc {ComputeStatistics DATATBL}
    N_ = {IntToFloat {Length DATATBL}}
    MEAN_ = {FoldL DATATBL fun {$ X Y} Y + X end 0.0} / N_

    %% Spread etc ...
    local
      DEV = {NewCell 0.0} AVGDEV = {NewCell 0.0}
      VARIANCE = {NewCell 0.0}
      SKEW = {NewCell 0.0} KURTOSIS = {NewCell 0.0}
    in
      for I in DATATBL do
        DEV := I - MEAN_
        AVGDEV := @AVGDEV + {Number.abs @DEV}
        VARIANCE := @VARIANCE + {Number.pow @DEV 2.0}
        SKEW := @SKEW + {Number.pow @DEV 3.0}
        KURTOSIS := @KURTOSIS + {Number.pow @DEV 4.0}
      end

      AVGDEV := @AVGDEV / N_
      VARIANCE := @VARIANCE / (N_ - 1.0)

      STDDEV_ = {Float.sqrt @VARIANCE}

      if @VARIANCE > 0.0 then
        SKEW := @SKEW / (N_ * @VARIANCE * STDDEV_)
        KURTOSIS := @KURTOSIS / (N_ * {Number.pow @VARIANCE 2.0}) - 3.0
      end

      AVGDEV_ = @AVGDEV VARIANCE_ = @VARIANCE SKEW_ = @SKEW KURTOSIS_ = @KURTOSIS
    end

    %% Median 
    local N = {FloatToInt N_} Mid = (N div 2) K = (Mid + 1) in
      if N mod 2 \= 0 then
        MEDIAN_ = {Nth DATATBL Mid}
      else
        MEDIAN_ = ({Nth DATATBL K} + {Nth DATATBL Mid}) / 2.0
      end
    end
  end

  proc {ShowStatistics}
    {System.showInfo "n:                  "#{FloatToInt N_}}

    {System.showInfo "median:             "#{FloatToString MEDIAN_ 6}}
    {System.showInfo "mean:               "#{FloatToString MEAN_ 6}}
    {System.showInfo "average_deviation:  "#{FloatToString AVGDEV_ 6}}
    {System.showInfo "standard_deviation: "#{FloatToString STDDEV_ 6}}
    {System.showInfo "variance:           "#{FloatToString VARIANCE_ 6}}
    {System.showInfo "skew:               "#{FloatToString SKEW_ 6}}
    {System.showInfo "kurtosis:           "#{FloatToString KURTOSIS_ 6}}
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
  {ComputeStatistics {Sort {LoadData {New TextFile init(name:stdin)}} fun {$ X Y} X < Y end}}

  {ShowStatistics}

  {Application.exit 0}
end

