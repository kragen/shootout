% The Computer Language Shootout                              
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import Application Open

define
   fun {NextHeader F}
      case {F getS($)} 
      of false then false
      elseof &>|_ = Header then Header
      else {NextHeader F} end
   end

   fun {ReversedLines F L}
      case {F getS($)} 
      of false then L # false
      elseof &>|_ = Header then L # Header
      elseof &;|_ then {ReversedLines F L}
      elseof Line then {ReversedLines F Line|L} end
   end


   local
      fun {IubCodeComplements}
         Code = "ABCDGHKMNRSTVWYabcdghkmnrstvwy"
         Comp = "TVGHCDMKNYSABWRTVGHCDMKNYSABWR"
         A = {NewArray 1 &z &*}
      in
         {List.forAllInd 
            {List.zip Code Comp fun{$ A B} A#B end}
               proc{$ I K#V} A.K := V end}
         A
      end

      IUB = {IubCodeComplements}

   in
      proc {WriteReverseComplement FOut ReversedLines}
         FirstLine|Lines = ReversedLines
         ShortestLength = {Length FirstLine}
      in 
         {FOut write(vs: {FoldL FirstLine fun{$ L C} IUB.C|L end nil}) }

         {ForAll Lines
            proc{$ Line}
               S = {List.foldLInd 
                  Line 
                  fun{$ I L C} 
                     if I == ShortestLength then &\n|IUB.C|L 
                     else IUB.C|L end 
                  end
                  nil}
            in
               {FOut write(vs: S)}               
            end            
         }
         {FOut write(vs: "\n")}
      end
   end


   proc {ReadRevCompWrite F Header FOut}
      if Header \= false then 
         Lines # NextHeader = {ReversedLines F nil}
      in
         {FOut write(vs: Header # "\n")}
         {WriteReverseComplement FOut Lines}
         {ReadRevCompWrite F NextHeader FOut}
      end
   end


   class TextFile from Open.file Open.text end
   StdIn = {New TextFile init(name:stdin)}
   StdOut = {New Open.file init(name:stdout)}
in
   {ReadRevCompWrite StdIn {NextHeader StdIn} StdOut}
   {Application.exit 0}   
end
