%%% $Id: sumcol.oz,v 1.3 2004-07-04 07:09:27 bfulgham Exp $
%%% http://dada.perl.it/shootout/
functor
import 
    System(printInfo)
    Application(exit)
    Open(text file)
    OS
define
class TextFile  
  from Open.file Open.text  
end 

fun {SumLines FILE SUM}
    case {FILE getS($)} of false then
        SUM
    elseof LINE then
        {SumLines FILE SUM+{String.toInt LINE}}
    end
end
    
in 
    local STDIN SUM in
        STDIN = {New TextFile init(name:stdin)}
        SUM = {SumLines STDIN 0}
        {System.printInfo SUM}
        {System.printInfo "\n"}
    end
    {Application.exit 0}
end
