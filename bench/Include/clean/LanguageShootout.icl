// The Great Computer Language Shootout 
// contributed by Isaac Gouy (Clean novice)


implementation module LanguageShootout
import StdEnv, ArgEnv

                                             
// The first commandline arg (if it will convert to Int) otherwise 1
argi :: Int
argi = if (argAsInt <= 0) 1 argAsInt
   where
      argv = getCommandLine
      argAsInt = if (size argv == 2) (toInt argv.[1]) 1


// Round to n decimal places & convert to String 
toStringWith :: !.Int !.Real -> {#Char}     
toStringWith n a
   # z = 10.0 ^(~ (toReal n))   
   # x = (0.5 * z) + abs a
   # (s,exp) = ndigits x z (entier x) (nsign a) 0
   # (s,exp) = nzeros s exp True
   = s

   where
   nsign x = if (x<0.0) "-" ""
      
   ndigits x z i s exp
      | x<z = (s,exp)
      # x = (x - toReal i)*10.0
      = ndigits x (z*10.0) (entier x) 
         ((if (exp == -1)(s +++ ".") s) +++ toString i) (exp-1)

   nzeros s exp point
      | exp < ~n = (s,exp)
      | (exp == -1 && point) = nzeros (s +++ ".") exp False
      = nzeros (s +++ "0") (exp-1) point 