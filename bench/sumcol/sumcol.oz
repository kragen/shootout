%%% $Id: sumcol.oz,v 1.2 2004-05-25 03:18:16 bfulgham Exp $
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
    {System.printInfo "file.atEnd="}
    if {FILE atEnd($)} == true then
        {System.printInfo "Y"}
    else
        {System.printInfo "N"}
    end
    {System.printInfo "\n"}
    case {FILE getS($)} of false then
        {System.printInfo "file terminated, returning "}
        {System.printInfo SUM}
        {System.printInfo "\n"}
        SUM
    elseof LINE then
        {System.printInfo "got "}
        {System.printInfo LINE}
        {System.printInfo "\n"}
        {SumLines FILE SUM+{String.toInt LINE}}
    end
end
    
in 
    local STDIN SUM in
        STDIN = {New TextFile init(name:stdin)}
        SUM = {SumLines STDIN 0}
        {System.printInfo SUM}
    end
    {Application.exit 0}
end
