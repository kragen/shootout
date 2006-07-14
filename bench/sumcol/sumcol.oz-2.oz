% The Computer Language Shootout                              
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import Application System Open

define
   fun {Sum F S}
      case {F getS($)} 
      of false then S
      elseof Line then {Sum F S+{String.toInt Line}} end
   end

   class TextFile from Open.file Open.text end
   StdIn = {New TextFile init(name:stdin)}
    
in    
   {System.showInfo {Sum StdIn 0} }
   {Application.exit 0}   
end
