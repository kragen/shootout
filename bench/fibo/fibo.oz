%%% $Id: fibo.oz,v 1.2 2004-06-26 11:10:46 ekarttun-guest Exp $
%%% http://dada.perl.it/shootout/
functor
import System Application
define
fun {Fib N}
	if N < 2 then 1 else {Fib N-2} + {Fib N-1} end
end
A
in 
    [A] = {Application.getArgs plain}
    {System.show {Fib {String.toInt A}}}
    {Application.exit 0}
end
