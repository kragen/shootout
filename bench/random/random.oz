%%% $Id: random.oz,v 1.2 2004-07-04 07:09:26 bfulgham Exp $
%%% http://dada.perl.it/shootout/
functor
import System Application Property
define
fun {RandLoop N SEED R MAX}
    case N 
    of 0 then R
    else 
        local IA IC IM NEWSEED NEWRAND in
            IM = 139968
            IA =   3877
            IC =  29573
            NEWSEED = (SEED * IA + IC) mod IM
            NEWRAND = MAX * {Int.toFloat NEWSEED}/{Int.toFloat IM}
            {RandLoop N-1 NEWSEED NEWRAND MAX}
        end
    end
end
in 
    local A NUM I in
        [A] = {Application.getArgs plain}
        NUM = {String.toInt A}
	{Property.put 'print.width' 12}
        {System.printInfo {RandLoop NUM 42 0 100.0}}
    end
    {Application.exit 0}
end
