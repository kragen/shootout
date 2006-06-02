% ----------------------------------------------------------------------
% The Great Computer Language Shootout                              
% http://shootout.alioth.debian.org/                                
%                                                                   
% Floating point conversion routines courtesy Juergen Stuber and Jorge
% Marques Pelizzoni [previously used in other Mozart/Oz Shootout
% submissions].
%
% Contributed by Anthony Borla
% ----------------------------------------------------------------------

functor

import
  System(showInfo) Application(exit) Open(file text)

define

  class TextFile_
    from Open.file Open.text
  end

% ------------- %

  SPACE = &\040

% ------------- %

  fun {NewKnucleotide FILE}

    proc {PrintFrequencies FragmentLength}
      Entries = {Dictionary.entries {GenerateCounts FragmentLength}}
      CountSum = {List.foldL Entries fun {$ A _#V} (A + {Int.toFloat V}) end 0.0}

      CalcFreq = fun {$ K#V} K#({Int.toFloat V} / CountSum) * 100.0 end
      Sorter = fun {$ X#Xt Y#Yt} if Xt == Yt then X > Y else Xt > Yt end end
      ShowEntry = proc {$ K#V} {System.showInfo K # " " # {FloatToString V 3}} end

    in
      {ForAll {List.sort {List.map Entries CalcFreq} Sorter} ShowEntry}
      {System.showInfo ""}
    end

    % ------------- %

    proc {PrintCount Fragment} Key = {String.toAtom Fragment} Count in
      Count = {Dictionary.condGet {GenerateCounts {List.length Fragment}} Key 0}
      {System.showInfo {PadRight SPACE {Int.toString Count} 8} # Fragment}
    end

    % ------------- %

    fun {GenerateCounts FragmentLength}
      Table = {NewDictionary}

      proc {Do_J SequenceSlice}
        case SequenceSlice of nil then
          skip
        else Key CurrentSlice RestSlice in
          {List.takeDrop SequenceSlice FragmentLength CurrentSlice RestSlice}
          if {List.length CurrentSlice} < FragmentLength then
            skip
          else
            Key = {String.toAtom CurrentSlice}
            {Dictionary.put Table Key ({Dictionary.condGet Table Key 0} + 1)}
            {Do_J RestSlice}
          end
        end
      end

    in
      for I in 1..FragmentLength do 
        if I > 1 then
          {Do_J {List.drop Sequence (I - 1)}}
        else
          {Do_J Sequence}
        end 
      end

      Table
    end

    % ------------- %

    fun {LoadSequence Loading Sequence_}
      if Loading then
        case {FILE getS($)} of false then
          {List.reverse Sequence_}
        elseof LINE then
          {LoadSequence Loading {List.append {List.reverse {List.map LINE Char.toUpper}} Sequence_}}
        end
      else
        case {FILE getS($)} of false then
          {List.reverse Sequence_}
        elseof &>|&T|&H|&R|&E|&E|_ then
          {LoadSequence true Sequence_}
        else
          {LoadSequence Loading Sequence_}
        end
      end
    end

    Sequence

  in
    Sequence = {LoadSequence false nil}
    ops(printFrequencies:PrintFrequencies printCount:PrintCount)
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

  fun {PadRight Ch String L}
    PL = L - {List.length String}
  in
    String # {MakePadding Ch PL}
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

  Knucleotide

% ------------- %

in
  Knucleotide = {NewKnucleotide {New TextFile_ init(name:stdin)}}

  {Knucleotide.printFrequencies 1}
  {Knucleotide.printFrequencies 2}

  {Knucleotide.printCount "GGT"}
  {Knucleotide.printCount "GGTA"}
  {Knucleotide.printCount "GGTATT"}
  {Knucleotide.printCount "GGTATTTTAATT"}
  {Knucleotide.printCount "GGTATTTTAATTTATAGT"}

  {Application.exit 0}
end

