% ----------------------------------------------------------------------
% The Great Computer Language Shootout                              
% http://shootout.alioth.debian.org/                                
%                                                                   
% Contributed by Anthony Borla
% ----------------------------------------------------------------------

functor

import
  System(printInfo) Application(exit) Open(text file)

define
  class TextFile_
    from Open.file Open.text
  end

  proc {ReverseComplement FILE Delimiter OutputLength}
    {ReadSegments FILE Delimiter OutputLength nil}
  end

  proc {ReadSegments FILE Delimiter OutputLength Segment}
    LINE = {FILE getS($)}
  in
    case LINE of false then
      {DumpSegment Segment OutputLength}
    elseof !Delimiter|_ then
      {DumpSegment Segment OutputLength}
      {PrintHeader LINE}
      {ReadSegments FILE Delimiter OutputLength nil}
    else
      {ReadSegments FILE Delimiter OutputLength {AddToSegment LINE Segment}}
    end
  end

  local
    P = proc {$ X} {System.printInfo X # "\n"} end
  in
    proc {DumpSegment Segment OutputLength}
      case Segment of nil then
        skip
      else
        {SplitAndApply {Map {Reverse Segment} Complement} OutputLength P}
      end
    end
  end

  proc {PrintHeader Header}
    {System.printInfo Header # "\n"}
  end

  fun {AddToSegment Item Segment}
    {Append Segment Item}
  end

  local
    CodeTbl = {ByteString.make [84 86 71 72 0 0 67 68 0 0 77 0 75 78 0 0 0 89 83 65 65 66 87 0 82 0]}
  in
    fun {Complement Code}
      {ByteString.get CodeTbl ({Char.toUpper Code} - 65)}
    end
  end

  proc {SplitAndApply L N P}
    X Xs
  in
    case L of nil then
      skip
    else
      {List.takeDrop L N X Xs} {P X} {SplitAndApply Xs N P}
    end
  end
in
  {ReverseComplement {New TextFile_ init(name:stdin)} &> 60}
  {Application.exit 0}
end

