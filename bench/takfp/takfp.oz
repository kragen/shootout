%%% $Id: takfp.oz,v 1.1 2005-03-07 05:49:47 bfulgham Exp $
%%% http://shootout.alioth.debian.org/
functor
import System Application
define
   fun {Tak X Y Z}
      if (Y >= X) then
	 Z
      else
	 {Tak
	  {Tak (X - 1.0) Y Z}
	  {Tak (Y - 1.0) Z X}
	  {Tak (Z - 1.0) X Y}}
      end
   end
   A N
in 
   [A] = {Application.getArgs plain}
   N = {Int.toFloat {String.toInt A}}
   {System.show {Tak (N*3.0) (N*2.0) (N*1.0)}}
   {Application.exit 0}
end