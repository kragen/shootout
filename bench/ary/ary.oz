%%% $Id: ary.oz,v 1.1 2004-05-23 05:43:44 bfulgham Exp $
%%% http://dada.perl.it/shootout/

%%% Code contributed by Andrew McDowell

functor
import
  System
  Application
define
 local Args N A1 A2 in

   {Application.getCmdArgs plain Args}
   if {List.length Args} \= 1 then 
     N = 1
   else
     {String.toInt Args.1 N}
   end

   {NewArray 0 N 0 A1} 
   {NewArray 0 N 0 A2} 

   {For 0 (N - 1) 1 
     proc {$ I} {Put A1 I (I + 1)} end }

   {For 0 999 1 
      proc {$ I} 
        {For (N - 1) 0 ~1 
          proc {$ I} {Put A2 I ({Array.get A2 I} + {Get A1 I})} end}
      end}


   {System.showInfo {Get A2 0}#" "#{Get A2 (N - 1)}}
   {Application.exit 0}
 end
end
