%%% $Id: fibo.oz,v 1.1 2004-05-23 06:11:24 bfulgham Exp $
%%% http://dada.perl.it/shootout/
functor
import System Application
define
fun {Fib N}
    case N
    of 0 then 1
    [] 1 then 1
    else {Fib N-2} + {Fib N-1} end
end
in 
    local A in
        [A] = {Application.getArgs plain}
        {System.printInfo {Fib {String.toInt A}}}
	{System.printInfo "\n"}
    end
    {Application.exit 0}
end
