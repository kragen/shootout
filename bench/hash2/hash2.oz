%%% $Id: hash2.oz,v 1.1 2004-05-23 06:21:23 bfulgham Exp $
%%% http://dada.perl.it/shootout/
%%% 
%%% contributed by Isaac Gouy

%%  Usage: start from command line with
%%     ozc -x hash2.oz -o hash2.oz.exe
%%     hash2.oz.exe 150

functor
import System Application

define

proc {InitHash H}
   for I in 0..9999 do 
      {Dictionary.put H
         {String.toAtom {List.append "foo_" {IntToString I}}} I} 
   end
end

proc {AddValues L H}
   local Key Value Tail V in
      if L \= nil then
         (Key#Value|Tail) = L
         {Dictionary.condGet H Key nil V}
         if V == nil then
            {Dictionary.put H Key Value}
         else
            {Dictionary.put H Key Value+V}
         end
         {AddValues Tail H}
      end
   end
end

in 
   local Args N H1 H2 in
      [Args] = {Application.getArgs plain}
      N = {String.toInt Args}

      {NewDictionary H1}
      {NewDictionary H2}

      {InitHash H1}
      for I in 1..N do 
         {AddValues {Dictionary.entries H1} H2} end

      {System.printInfo {Dictionary.get H1 'foo_1'}}
      {System.printInfo ' '}
      {System.printInfo {Dictionary.get H1 'foo_9999'}}
      {System.printInfo ' '}
      {System.printInfo {Dictionary.get H2 'foo_1'}}
      {System.printInfo ' '}
      {System.printInfo {Dictionary.get H2 'foo_9999'}}
      {System.printInfo "\n"}
   end
   {Application.exit 0}
end
