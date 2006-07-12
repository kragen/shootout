% The Computer Language Shootout                              
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import
   System Application
   S at '../../Include/oz/shootout.ozf'  

define
   TwoThirds = 2.0/3.0
   [Arg] = {Application.getArgs plain}
   N = {String.toInt Arg}

   fun {Sums I A1 A2 A3 A4 A5 A6 A7 A8 A9 Alt}
      if I =< N then
         K K2 K3 SK CK 
      in
         K = {IntToFloat I}
         K2 = K * K
         K3 = K2 * K
         SK = {Sin K}
         CK = {Cos K}

         {Sums 
            I+1 	 
            A1 + {Pow TwoThirds K-1.0}
            A2 + 1.0/{Sqrt K}
            A3 + 1.0/(K*(K+1.0))
            A4 + 1.0/(K3*(SK*SK))
            A5 + 1.0/(K3*(CK*CK))	 
            A6 + 1.0/K
            A7 + 1.0/K2
            A8 + Alt/K
            A9 + Alt/(2.0*K - 1.0)
            ~Alt }
      else
         A1 # A2 # A3 # A4 # A5 # A6 # A7 # A8 # A9
      end
   end

   A = {Sums 1 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 1.0 }
in   
   {System.showInfo {S.floatToString A.1 9}#"\t(2/3)^k"}
   {System.showInfo {S.floatToString A.2 9}#"\tk^-0.5"}
   {System.showInfo {S.floatToString A.3 9}#"\t1/k(k+1)"}
   {System.showInfo {S.floatToString A.4 9}#"\tFlint Hills"}
   {System.showInfo {S.floatToString A.5 9}#"\tCookson Hills"}
   {System.showInfo {S.floatToString A.6 9}#"\tHarmonic"}
   {System.showInfo {S.floatToString A.7 9}#"\tRiemann Zeta"}
   {System.showInfo {S.floatToString A.8 9}#"\tAlternating Harmonic"}
   {System.showInfo {S.floatToString A.9 9}#"\tGregory"}
   {Application.exit 0}   
end
