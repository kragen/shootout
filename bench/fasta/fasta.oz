% The Computer Language Benchmarks Game  
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import Application Open

define
   % lists convenient for declaring data

   RawALU = 
      "GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG" #
      "GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA" #
      "CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT" #
      "ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA" #
      "GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG" #
      "AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC" #
      "AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA"

   RawIUB = [
      "a"#0.27 "c"#0.12 "g"#0.12 "t"#0.27
      "B"#0.02 "D"#0.02 "H"#0.02 "K"#0.02
      "M"#0.02 "N"#0.02 "R"#0.02 "S"#0.02
      "V"#0.02 "W"#0.02 "Y"#0.02 ]

   RawHomoSapiens = [
      "a"# 0.3029549426680
      "c"# 0.1979883004921
      "g"# 0.1975473066391
      "t"# 0.3015094502008 ]


   % arrays faster for indexed selection

   fun {MakeStringArray L} 
      A = {NewArray 1 {Length L} nil}
   in
     {List.forAllInd L 
        proc{$ I C} A.I := [C] end}
     A
   end

   fun {MakeCumulative L}
      N = {Length L}
      A = {NewArray 1 N 0}
      Sum = {NewCell 0.0}

      proc {Acc I Code#Percent}
         A.I := Code # (Percent + @Sum)
         Sum := @Sum + Percent
      end
   in 
      {List.forAllInd L Acc}
      A
   end

   ALU = {MakeStringArray {VirtualString.toString RawALU} }
   IUB = {MakeCumulative RawIUB}
   HomoSapiens = {MakeCumulative RawHomoSapiens}


   % random selection

   fun {PseudoRandomFunction Max}
      IM = 139968 IMF = 139968.0
      IA = 3877
      IC = 29573
      Seed = {NewCell 42} 
   in
      fun {$} 
         Seed := (@Seed * IA + IC) mod IM
         Max * {IntToFloat @Seed} / IMF
      end
   end

   RandomNumber = {PseudoRandomFunction 1.0}


   fun {SelectRandom A}      
      fun {Select R A I N}   % simple sequential search
         Code#Percent = A.I
      in 
         if R =< Percent then Code else {Select R A I+1 N} end
      end      
   in 
      {Select {RandomNumber} A {Array.low A} {Array.high A}}
   end   


   % based on Paul Hsieh's C program
   proc {MakeRandomFasta Id Desc A N F}
      fun {Line I L}
         if I > 0 then {Line I-1 L#{SelectRandom A} } else L end
      end
   in
      {F  write(vs: ">" # Id # " " # Desc # "\n")}

      for I in N; I > 0; I-LineLength do
         M = if I < LineLength then I else LineLength end
      in
         {F  write(vs: {Line M ""} # "\n")}
      end
   end


   % repeat selection

   proc {MakeRepeatFasta Id Desc A N F}
      Start = {NewCell 1}
      Last = {Array.high A}

      fun {Line I N L}
         if I =< N then {Line I+1 N L#A.I } else L end
      end
   in
      {F write(vs: ">" # Id # " " # Desc # "\n")}

      for I in N; I > 0; I-LineLength do
         M = if I < LineLength then I else LineLength end
         K = @Start + M - 1
         Stop = if K > Last then K-Last else K end
         L
      in
         if K > Last then
            L = {Line @Start Last nil}
            Start := 1
         else
            L = nil          
         end
         {F write(vs: {Line @Start Stop L} # "\n") }
         Start := Stop + 1 
      end
   end


   LineLength = 60

   [Arg] = {Application.getArgs plain}
   N = {String.toInt Arg}
   StdOut = {New Open.file init(name:stdout)}

in   
   {MakeRepeatFasta "ONE" "Homo sapiens alu" ALU N*2 StdOut}
   {MakeRandomFasta "TWO" "IUB ambiguity codes" IUB N*3 StdOut} 
   {MakeRandomFasta "THREE" "Homo sapiens frequency" HomoSapiens N*5 StdOut} 
   {Application.exit 0}   
end
