% The Computer Language Benchmarks Game  
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import Application Open

define
   fun {NextHeader F}
      case {F getS($)} 
      of false then false
      [] &>|_ = Header then Header
      else {NextHeader F} end
   end

   fun {ReversedLines F L}
      case {F getS($)} 
      of false then L # false
      [] &>|_ = Header then L # Header
      [] &;|_ then {ReversedLines F L}
      [] Line then {ReversedLines F Line|L} end
   end


   local
      fun {IubCodeComplements}
         Code = "ABCDGHKMNRSTVWYabcdghkmnrstvwy"
         Comp = "TVGHCDMKNYSABWRTVGHCDMKNYSABWR"
         A = {NewArray 1 &z &*}
      in
         {ForAll
            {List.zip Code Comp fun{$ K V} K#V end}
               proc{$ K#V} A.K := V end}
         A
      end

      IUB = {IubCodeComplements}

   in
      proc {WriteReverseComplement FOut FirstLine|RemainingLines}
         ShortestLength = {Length FirstLine}

         fun {ReverseComplement L C} IUB.C|L end

         fun {FastaReverseComplement I L C} 
            if I == ShortestLength then &\n|IUB.C|L 
            else IUB.C|L end 
         end

      in 
         {FOut write(vs: {FoldL FirstLine ReverseComplement nil}) }

         for Line in RemainingLines do
            {FOut write(vs: {List.foldLInd Line FastaReverseComplement nil})}
         end
         {FOut write(vs: "\n")}
      end
   end


   proc {ReadReverseComplementWrite F Header FOut}
      if Header \= false then 
         Lines # NextHeader = {ReversedLines F nil}
      in
         {FOut write(vs: Header # "\n")}
         {WriteReverseComplement FOut Lines}
         {ReadReverseComplementWrite F NextHeader FOut}
      end
   end

   class TextFile from Open.file Open.text end
   StdIn = {New TextFile init(name:stdin)}
   StdOut = {New Open.file init(name:stdout)}
in
   {ReadReverseComplementWrite StdIn {NextHeader StdIn} StdOut}
   {Application.exit 0}   
end
