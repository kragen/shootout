%%% $Id: ackermann.oz,v 1.1 2004-05-23 05:36:23 bfulgham Exp $
%%% http://dada.perl.it/shootout/
functor
import System Application
define
fun {Ack M N}
    if M==0 then N + 1
    elseif N == 0 then {Ack M-1 1}
    else {Ack M-1 {Ack M N-1}}
    end
end
in 
    local A in
        [A] = {Application.getArgs plain}
        {System.printInfo "Ack(3,"}
        {System.printInfo A}
        {System.printInfo "): "}
        {System.printInfo {Ack 3 {String.toInt A}}}
	{System.printInfo "\n"}
    end
    {Application.exit 0}
end
