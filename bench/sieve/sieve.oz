%%% $Id: sieve.oz,v 1.1 2004-05-23 07:14:28 bfulgham Exp $
%%% http://dada.perl.it/shootout/

%%% 
%%% contributed by Isaac Gouy

%%  Usage: start from command line with
%%     ozc -x sieve.oz -o sieve.oz.exe
%%     sieve.oz.exe 900

functor
import System Application

define Args N Flags Start Stop in

    [Args] = {Application.getArgs plain}
    N = {String.toInt Args}

    Start = 2
    Stop = 8192

    Flags = {BitArray.new Start Stop}
    for I in Start..Stop do {BitArray.set Flags I} end

    for I in 1..N do
           for J in Start..Stop do
            if {BitArray.test Flags J} then
                for K in J+J..Stop;J do {BitArray.clear Flags K} end 
            end
        end
    end

   {System.showInfo "Count: "#{BitArray.card Flags}}

   {Application.exit 0}
end
