% The Computer Language Benchmarks Game                           
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import 
   Application System Open
   S at 'Include/oz/shootout.ozf'

define
   Sequence

   proc {FindSequence F Id}
      case {F getS($)} 
      of false then skip
      [] &>|T then 
         if {List.isPrefix Id T} then skip else {FindSequence F Id} end
      else {FindSequence F Id} end
   end

   fun {ReadSequence F S}
      case {F getS($)} 
      of false then S
      [] &>|_ then S 
      [] &;|_ then {ReadSequence F S}
      [] Line then {ReadSequence F S#{Map Line Char.toUpper}} end
   end

   fun {GenerateFrequencies Length}
      D = {NewDictionary}

      proc {KFrequency Offset J}
         N = {ByteString.length Sequence} - J + 1
      in 
         for I in Offset; I<N; I+J do
            Slice = {ByteString.slice Sequence I I+J} 
            K = {String.toAtom {ByteString.toString Slice}}
            V = {Dictionary.condGet D K nil}
         in
            if V == nil then {Dictionary.put D K {NewCell 1}}
            else V := @V + 1 end
         end
      end
   in
      for Offset in 0; Offset<Length; Offset+1 do 
         {KFrequency Offset Length} 
      end
      D
   end

   proc {WriteFrequencies J}
      D = {GenerateFrequencies J}
      F = fun {$ Ak#Av Bk#Bv} if @Av==@Bv then Ak>Bk else @Av>@Bv end end
      L = {Sort {Dictionary.entries D} F}
      N = {IntToFloat {ByteString.length Sequence} - J + 1}
   in
      for K#V in L do 
         Percentage = {IntToFloat @V} / N * 100.0
      in
         {System.showInfo K # " " # {S.floatToString Percentage 3}}          
      end
      {System.showInfo ""} 
   end

   proc {WriteCount Fragment}
      D = {GenerateFrequencies {Length Fragment}}
      K = {String.toAtom Fragment}
      Count = {Dictionary.condGet D K {NewCell 0}}
   in
      {System.showInfo @Count # "\t" # Fragment}
   end

   class TextFile from Open.file Open.text end
   StdIn = {New TextFile init(name:stdin)}

in    
   {FindSequence StdIn "THREE"}
   Sequence = {VirtualString.toByteString {ReadSequence StdIn nil}}

   {WriteFrequencies 1}
   {WriteFrequencies 2}

   {WriteCount "GGT"}
   {WriteCount "GGTA"}
   {WriteCount "GGTATT"}
   {WriteCount "GGTATTTTAATT"}
   {WriteCount "GGTATTTTAATTTATAGT"}

   {Application.exit 0}   
end
