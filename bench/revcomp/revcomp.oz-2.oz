% The Computer Language Shootout                              
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import Application Open

define
   fun {NextDesc F}
      case {F getS($)} 
      of false then false
      elseof &>|T then {Append ">" T}
      else {NextDesc F} end
   end

   fun {ReadSequence F S}
      case {F getS($)} 
      of false then S # false
      elseof &>|T then S # {Append ">" T}
      elseof &;|_ then {ReadSequence F S}
      elseof Line then {ReadSequence F S#Line} end
   end


   local
      LineLength = 60

      fun {IubCodeComplements}
         Code = "ABCDGHKMNRSTVWY"
         Comp = "TVGHCDMKNYSABWR"
         A = {NewArray 1 &Z &*}
      in
         {List.forAllInd 
            {List.zip Code Comp fun{$ A B} A#B end}
               proc{$ I K#V} A.K := V end}
         A
      end

      IUB = {IubCodeComplements}

      fun {Complement C} K = {Char.toUpper C} in IUB.K end

   in
      proc {WriteComplement FOut S}
         if S \= nil then 
            H T
         in
            {List.takeDrop S LineLength H T}
            {FOut putS({Map H Complement})}
            {WriteComplement FOut T}
         end
      end
   end


   proc {ReadRevCompWrite F D FOut}
      if D \= false then 
         S # ND = {ReadSequence F nil}
      in
         {FOut putS(D)}
         {WriteComplement FOut {Reverse {VirtualString.toString S}}}
         {ReadRevCompWrite F ND FOut}
      end
   end


   class TextFile from Open.file Open.text end
   StdIn = {New TextFile init(name:stdin)}
   StdOut = {New TextFile init(name:stdout)}
in
   {ReadRevCompWrite StdIn {NextDesc StdIn} StdOut}
   {Application.exit 0}   
end
