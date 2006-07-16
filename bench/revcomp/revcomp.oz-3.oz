% ----------------------------------------------------------------------
% The Great Computer Language Shootout                              
% http://shootout.alioth.debian.org/                                
%                                                                   
% Attempt at a faster implementation by:
%
% * Avoiding, where possible, the use of list append operations [lists
%   are stored in a stack rather than being appended]
% * Restricting the size of lists which are created, thus ensuring
%   list operations like 'map' and 'reverse' don't 'choke' :)
%
% Use made of code from 'Concepts, Techniques and Models of Computer
% Programming' [CTM] by P. van Roy, S. Haridi.
% 
% Contributed by Anthony Borla
% ----------------------------------------------------------------------

functor

import
  System(showInfo) Application(exit) Open(text file)

define

% ------------- %

  class TextFile_
    from Open.file Open.text
  end

% ------------- %

  proc {ReverseComplement FILE Delimiter OutputLength}

    proc {ReadSegments Segment} LINE = {FILE getS($)} in
      case LINE of false then
        {DumpSegment Segment OutputLength}
      elseof !Delimiter|_ then
        {DumpSegment Segment OutputLength}
        {PrintHeader LINE}
        {ReadSegments Segment}
      else
        {ReadSegments {AddToSegment LINE Segment}}
      end
    end
  in
    {ReadSegments {NewStack}}
  end

% ------------- %

  proc {DumpSegment Segment OutputLength}

    proc {DumpSegment_}
      if {Segment.isEmpty} then
        if @Spill \= nil then {System.showInfo @Spill} Spill := nil end
      else OutputLine in
        Spill := {List.takeDrop {List.append @Spill {Segment.pop}} OutputLength OutputLine}
        {System.showInfo OutputLine}
        {DumpSegment_}
      end
    end

    Spill = {NewCell nil}
  in
    if {Not {Segment.isEmpty}} then Spill := {List.append @Spill {Segment.pop}} end
    {DumpSegment_}
  end

% ------------- %

  proc {PrintHeader Header}
    {System.showInfo Header}
  end

% ------------- %

  fun {AddToSegment Sequence Segment}
    {Segment.push {Map {Reverse Sequence} Complement}}
    Segment
  end

% ------------- %

  local
    CodeTbl = {ByteString.make [84 86 71 72 0 0 67 68 0 0 77 0 75 78 0 0 0 89 83 65 65 66 87 0 82 0]}
  in
    fun {Complement Code}
      {ByteString.get CodeTbl ({Char.toUpper Code} - 65)}
    end
  end

  %
  % A conventional, dictionary-based [i.e. hash table] version; marginally slower performance
  %  
  % local
  %   CodeTbl =
  %     {Record.toDictionary
  %       codes('A':&T 'B':&V 'C':&G 'D':&H 'G':&C
  %             'H':&D 'K':&M 'M':&K 'N':&N 'R':&Y
  %             'S':&S 'T':&A 'V':&B 'W':&W 'Y':&R)}
  % in
  %   fun {Complement Code}
  %     {Dictionary.get CodeTbl {Char.toAtom {Char.toUpper Code}}}
  %   end
  % end
  %

% ------------- %

  %% General Purpose Stateful Stack [CTM implementation]

  fun {NewStack}
    C = {NewCell nil}

    proc {Push X} S in S = @C C := X|S end

    fun {Pop} S1 in
      S1 = @C
      case S1 of X|S then
        C := S
        X
      end
    end

    fun {IsEmpty} S in S = @C S == nil end
  in
    ops(push:Push pop:Pop isEmpty:IsEmpty)
  end

% ------------- %

  DELIMITER = &> LINESIZE = 60

% ------------- %

in
  {ReverseComplement {New TextFile_ init(name:stdin)} DELIMITER LINESIZE}
  {Application.exit 0}
end

