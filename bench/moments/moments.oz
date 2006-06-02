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

% ------------- %

  class TextFile_
    from Open.file Open.text
  end

% ------------- %

  fun {LoadData FILE}
    case {FILE getS($)} of false then
      nil
    elseof DATUM then
      {Int.toFloat {String.toInt DATUM}}|{LoadData FILE}
    end
  end

% ------------- %

  local
    N MEAN MEDIAN AVGDEV STDDEV VARIANCE SKEW KURTOSIS

  in

    proc {ShowStatistics}
      {System.showInfo "n:                  " # {FloatToInt N}}
      {System.showInfo "median:             " # {FloatToString MEDIAN 6}}
      {System.showInfo "mean:               " # {FloatToString MEAN 6}}
      {System.showInfo "average_deviation:  " # {FloatToString AVGDEV 6}}
      {System.showInfo "standard_deviation: " # {FloatToString STDDEV 6}}
      {System.showInfo "variance:           " # {FloatToString VARIANCE 6}}
      {System.showInfo "skew:               " # {FloatToString SKEW 6}}
      {System.showInfo "kurtosis:           " # {FloatToString KURTOSIS 6}}
    end

    % ------------- %

    proc {ComputeStatistics DATATBL}

      !N = {IntToFloat {Length DATATBL}}
      !MEAN = {FoldL DATATBL fun {$ X Y} Y + X end 0.0} / N

      % ------------- %

      proc {ComputeSpread}
        DEV_ = {NewCell 0.0} AVGDEV_ = {NewCell 0.0} VARIANCE_ = {NewCell 0.0}
        SKEW_ = {NewCell 0.0} KURTOSIS_ = {NewCell 0.0}
      in
        for I in DATATBL do
          DEV_ := I - MEAN
          AVGDEV_ := @AVGDEV_ + {Number.abs @DEV_}
          VARIANCE_ := @VARIANCE_ + {Number.pow @DEV_ 2.0}
          SKEW_ := @SKEW_ + {Number.pow @DEV_ 3.0}
          KURTOSIS_ := @KURTOSIS_ + {Number.pow @DEV_ 4.0}
        end

        AVGDEV_ := @AVGDEV_ / N
        VARIANCE_ := @VARIANCE_ / (N - 1.0)
        STDDEV = {Float.sqrt @VARIANCE_}

        if @VARIANCE_ > 0.0 then
          SKEW_ := @SKEW_ / (N * @VARIANCE_ * STDDEV)
          KURTOSIS_ := @KURTOSIS_ / (N * {Number.pow @VARIANCE_ 2.0}) - 3.0
        end

        AVGDEV = @AVGDEV_ VARIANCE = @VARIANCE_ SKEW = @SKEW_ KURTOSIS = @KURTOSIS_
      end

      % ------------- %

      proc {ComputeMedian Median}
        Ni = {FloatToInt N}  Mid = (Ni div 2)  K = (Mid + 1)
      in
        Median = if Ni mod 2 \= 0 then
          {Nth DATATBL Mid}
        else
          ({Nth DATATBL K} + {Nth DATATBL Mid}) / 2.0
        end
      end

      % ------------- %

    in 
      {ComputeMedian MEDIAN}
      {ComputeSpread}
    end

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

in
  {ComputeStatistics {Sort {LoadData {New TextFile_ init(name:stdin)}} fun {$ X Y} X < Y end}}
  {ShowStatistics}
  {Application.exit 0}
end

