% The Computer Language Shootout                              
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import
   System Application
   S at '../../Include/oz/shootout.ozf' 
define
   TwoThirds = 2.0/3.0
   A1 = {NewCell 0.0}
   A2 = {NewCell 0.0}
   A3 = {NewCell 0.0}
   A4 = {NewCell 0.0}
   A5 = {NewCell 0.0}
   A6 = {NewCell 0.0}
   A7 = {NewCell 0.0}
   A8 = {NewCell 0.0}
   A9 = {NewCell 0.0}
   Alt = {NewCell ~1.0}
   [Arg] = {Application.getArgs plain}
   N = {String.toInt Arg}
in   
   for I in 1..N do
      local K K2 K3 SK CK in
         K = {IntToFloat I}
         K2 = K * K
         K3 = K2 * K
         SK = {Sin K}
         CK = {Cos K}
	 
         A1 := @A1 + {Pow TwoThirds K-1.0}
         A2 := @A2 + 1.0/{Sqrt K}
         A3 := @A3 + 1.0/(K*(K+1.0))
         A4 := @A4 + 1.0/(K3*(SK*SK))
         A5 := @A5 + 1.0/(K3*(CK*CK))	 
         A6 := @A6 + 1.0/K
         A7 := @A7 + 1.0/K2

         Alt := ~ @Alt
         A8 := @A8 + @Alt/K
         A9 := @A9 + @Alt/(2.0*K - 1.0)
      end
   end
   {System.showInfo {S.floatToString @A1 9}#"\t(2/3)^k"}
   {System.showInfo {S.floatToString @A2 9}#"\tk^-0.5"}
   {System.showInfo {S.floatToString @A3 9}#"\t1/k(k+1)"}
   {System.showInfo {S.floatToString @A4 9}#"\tFlint Hills"}
   {System.showInfo {S.floatToString @A5 9}#"\tCookson Hills"}
   {System.showInfo {S.floatToString @A6 9}#"\tHarmonic"}
   {System.showInfo {S.floatToString @A7 9}#"\tRiemann Zeta"}
   {System.showInfo {S.floatToString @A8 9}#"\tAlternating Harmonic"}
   {System.showInfo {S.floatToString @A9 9}#"\tGregory"}
   {Application.exit 0}   
end
