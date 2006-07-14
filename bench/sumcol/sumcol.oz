% The Computer Language Shootout                              
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import Application System Open

define
   fun {Sum F S}
      L = {F getS($)} 
   in 
      if L == false then S else {Sum F S+{String.toInt L}} end
   end

   class TextFile from Open.file Open.text end
   StdIn = {New TextFile init(name:stdin)}
 
in    
   {System.showInfo {Sum StdIn 0} }
   {Application.exit 0}   
end
