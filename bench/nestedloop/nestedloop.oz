%%% $Id: nestedloop.oz,v 1.1 2004-05-23 07:14:28 bfulgham Exp $
%%% http://dada.perl.it/shootout/
%%% 
%%% Isaac Gouy suggested the use of a cell

functor
import System Application
define

    local P X A B C D E F N in
        [P] = {Application.getArgs plain}
        N = {String.toInt P}
        X = {NewCell 0}
        for A in 1..N do
            for B in 1..N do
                for C in 1..N do
                    for D in 1..N do
                        for E in 1..N do
                            for F in 1..N do
                                {Assign X {Access X}+1}
                            end
                        end
                    end
                end
            end
        end
        {System.printInfo {Access X}}
    end
    {Application.exit 0}
end
