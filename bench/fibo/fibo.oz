%%% $Id: fibo.oz,v 1.3 2005-03-19 00:32:56 igouy-guest Exp $
%%% http://dada.perl.it/shootout/
functor
import System Application
define
fun {Fib N}
	if N < 2 then N else {Fib N-2} + {Fib N-1} end
end
A
in 
    [A] = {Application.getArgs plain}
    {System.show {Fib {String.toInt A}}}
    {Application.exit 0}
end
