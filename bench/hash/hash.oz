%%% $Id: hash.oz,v 1.2 2004-07-04 07:09:25 bfulgham Exp $
%%% http://dada.perl.it/shootout/
%%% 
%%% contributed by Isaac Gouy

%%  Usage: start from command line with
%%     ozc -x hash.oz -o hash.oz.exe
%%     hash.oz.exe 2000

functor
import System Application

define

   fun {IntToHexString I Hex}
      if I =< 0 then Hex else
     local M D in 
        D = I div 16
        M = I mod 16
        if M < 10 then 
           {IntToHexString D M+&0|Hex}
        else
           {IntToHexString D (M-10)+&a|Hex}
        end
     end
      end
   end

   proc {InsertHexKeys H N}
      for I in 0..N do 
    {Dictionary.put H {String.toAtom {IntToHexString I nil}} I}
      end
   end

   proc {CountLookups H I S C}
      if I >= 0 then 
     if {Dictionary.member H {String.toAtom {IntToString I}}} then
        {CountLookups H I-1 S+1 C}
     else 
        {CountLookups H I-1 S C}
     end
      else C = S end
   end

in 
   local Args N H Count in
      [Args] = {Application.getArgs plain}
      N = {String.toInt Args}

      {NewDictionary H}
      {InsertHexKeys H N}
      {CountLookups H N+1 0 Count}

      {System.showInfo Count}
   end
   {Application.exit 0}
end
