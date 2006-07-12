% The Computer Language Shootout                              
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import Application System Open

define
   class TextFile from Open.file Open.text end
   StdIn = {New TextFile init(name:stdin)}
   Sum = {NewCell 0} 
in    
   for break:B do 
      local Line in
         Line = {StdIn getS($)}
         if Line == false then {B} end
         Sum := @Sum + {StringToInt Line}
      end 
   end
   {System.showInfo @Sum}
   {Application.exit 0}   
end
