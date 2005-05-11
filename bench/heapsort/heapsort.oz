%%% $Id: heapsort.oz,v 1.3 2005-05-11 16:29:48 igouy-guest Exp $
%%% http://dada.perl.it/shootout/
%%%
%%% contributed by Isaac Gouy 
%%% Using string conversion routines suggested by Juergen Stuber
%%%   and Jorge Marques Pelizzoni

%%  Transliterated from the Mercury solution
%%
%%  Usage: start from command line with
%%     ozc -x heapsort.oz -o heapsort.oz.exe
%%     heapsort.oz.exe 1000

functor
import System Application

define
   IM = 139968
   IA = 3877
   IC = 29573
   Seed = 42
   
   fun {Random_heap H I S0}
      local R S in
     if I =< {Array.high H} then
        {Gen_random R S0 S}
        {Random_heap {Up_heap H I R} I+1 S}
     else
        H
     end
      end
   end

   fun {Up_heap H N Y}
      local HalfN X in
     HalfN = N div 2
     X = {Get H HalfN}
     if 0 < N andthen X < Y then
        {Put H N X}
        {Up_heap H HalfN Y}
     else
        {Put H N Y}
        H
     end
      end
   end

   fun {Heapsort H N}
      if N == 0 then H
      else {Heapsort {Remove_greatest H N} N-1} end
   end

   fun {Remove_greatest H N}
      local X Y in
     X = {Get H 0}
     Y = {Get H N}
     {Put H N X}
     {Down_heap H 0 N-1 Y}
      end
   end

   fun {Down_heap H I N X}
      local L R J Y in
     L = I + I + 1
     R = L + 1
     if N < L then
        {Put H I X}
        H
     else
        J = if R < N andthen {Get H R} > {Get H L}
        then  R else L end
        Y = {Get H J}
        if X > Y then
           {Put H I X}
           H
        else
           {Put H I Y}
           {Down_heap H J N X}
        end
     end
      end
   end

   proc {Gen_random R S0 S}
      S = (S0 * IA + IC) mod IM
      R = {IntToFloat S} / {IntToFloat IM}
   end

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
	 in
	    {PadLeft &0 {IntToString Digits} Prec}
	 end
      end

      I = {FloatToInt {if F >= 0.0 then Floor else Ceil end F}}
      Frac = {FloatAbs F - {IntToFloat I}}
   in
      {IntToString I} # "." # {FractionToString Frac Prec}
   end

   fun {FloatToString F Prec}
      {VirtualString.toString {FloatToVS F Prec}}
   end   
in
   local Args N RandomHeap SortedHeap in
      [Args] = {Application.getArgs plain}
      N = {String.toInt Args}
      RandomHeap = {Random_heap {NewArray 0 N-1 0.0} 0 Seed}
      SortedHeap = {Heapsort RandomHeap N-1}
      {System.showInfo {FloatToString {Get SortedHeap N-1} 9}}
   end
   {Application.exit 0}
end
