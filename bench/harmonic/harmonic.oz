%%% $Id: harmonic.oz,v 1.3 2005-03-06 05:21:23 bfulgham Exp $
%%%
%%% http://shootout.alioth.debian.org/
%%% Contributed by Brent Fulgham
%%% using String conversion routines proposed by Juergen Stuber
%%%   and Jorge Marques Pelizzoni
functor
import System Application
define
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
   
   fun {Sum_Harmonic Goal Curr Accum}
      if Curr>Goal then
	 Accum
      else
	 {Sum_Harmonic Goal (Curr + 1) (Accum + 1.0 / {Int.toFloat Curr})}
      end
   end
in
   local A in
      [A] = {Application.getArgs plain}
      {System.printInfo {FloatToString {Sum_Harmonic {String.toInt A} 1 0.0} 9 }}
      {System.printInfo "\n"}
   end
   {Application.exit 0}
end
