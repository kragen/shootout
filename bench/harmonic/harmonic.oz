%%% $Id: harmonic.oz,v 1.1 2005-03-03 01:01:53 bfulgham Exp $
%%% http://shootout.alioth.debian.org/
functor
import System Application
define
   fun {Sum_Harmonic M}
      local PartialSum in
	 PartialSum = {NewCell 0.}
	 for I in 1..M;1 do
	    local Old New in
	       {Exchange PartialSum Old New}
	       New = Old + 1.0 / {Int.toFloat I}
	    end
	 end
	 @PartialSum
      end
   end
in
   local A in
      [A] = {Application.getArgs plain}
      {System.printInfo {Sum_Harmonic {String.toInt A}}}
      {System.printInfo "\n"}
   end
   {Application.exit 0}
end