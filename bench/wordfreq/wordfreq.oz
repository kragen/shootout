% ----------------------------------------------------------------------
% The Great Computer Language Shootout                              
% http://shootout.alioth.debian.org/                                
%                                                                   
% Word frequency benchmark implemented in a functional style, and using
% only native list processing facilities. An alternate version using
% regexp is included within comment markers interspersed throughout the
% code. List processing version appears to be faster and more efficient,
% in general at least 50% faster. 
% 
% Contributed by Anthony Borla
% ----------------------------------------------------------------------

functor

import
  System(showInfo) Application(exit) Open(file text)

  %
  %  Regex at 'x-oz://contrib/regex'
  %

define
  class TextFile_
    from Open.file Open.text
  end

% ------------- %

  LF = &\012 SPACE = &\040

% ------------- %

  fun {MakeWordFreqTable FILE}

    proc {AddToTable E} Key in
      if E \= nil then
        Key = {String.toAtom E}
        {Dictionary.put Table Key ({Dictionary.condGet Table Key 0} + 1)}
      end
    end

    % ------------- %

    %
    % local
    %   CFT = {MakeCFT Char.isSpace nil Char.toLower}
    % in
    %   fun {CompressLowercaseAndSplit S}
    %     {String.tokens {CFT S false} SPACE}
    %   end
    % end
    %
    % RX = {Regex.make "[^A-Za-z]"}
    %

    local
      Fp = fun {$ E} {Not {Char.isAlpha E}} end
      CFT = {MakeCFT Char.isSpace Fp Char.toLower}
    in
      fun {CompressFilterLowercaseAndSplit S}
        {String.tokens {CFT S false} SPACE}
      end
    end

    % ------------- %

    proc {LoadTable}
      case {FILE getS($)} of false then
        skip
      elseof !LF|_ then
        skip
      elseof LINE then

        %
        % {ForAll
        %    {CompressLowercaseAndSplit
        %      {ByteString.toString {Regex.replace
        %         LINE
        %         RX
        %         fun {$ X Y} " " end}}}
        %    AddToTable}
        %

        {ForAll
          {CompressFilterLowercaseAndSplit LINE}
          AddToTable}

        {LoadTable}
      end
    end

    % ------------- %

    Table = {NewDictionary}
  in
    {LoadTable}
    Table
  end

% ------------- %

  fun {MakeCFT Cp Fp Tp}
    Compressable = if Cp \= nil then Cp else fun {$ E} E end end
    Filterable = if Fp \= nil then Fp else fun {$ _} false end end
    Transform = if Tp \= nil then Tp else fun {$ E} E end end

    fun {CFT S Flag}
      case S of nil then nil
      elseof H|T then Pt in
        if (Pt = {Compressable H}) then
          if Flag then
            {CFT T true}
          else
            if {Filterable H} then SPACE|{CFT T Pt} else H|{CFT T Pt} end
          end
        else
          if {Filterable H} then
            SPACE|{CFT T Pt}
          else
            {Transform H}|{CFT T Pt}
          end
        end
      end
    end
  in
    CFT
  end

  fun {PadLeft S Padlen C} {List.append {MakePad S Padlen C} S} end

  fun {MakePad S Padlen C}
    L Reqlen = {List.length S} - Padlen
  in
    if Reqlen < 0 then
      L = {List.make {Number.abs Reqlen}}
      for I in L do I = C end
    else
      L = nil
    end
    L
  end

% ------------- %

  Sorter ShowEntry

% ------------- %

in
  Sorter = fun {$ X#Xt Y#Yt} if Xt == Yt then X > Y else Xt > Yt end end
  ShowEntry = proc {$ K#V} {System.showInfo {PadLeft {Int.toString V} 7 SPACE} # " " # K} end

  {ForAll
    {List.sort {Dictionary.entries {MakeWordFreqTable {New TextFile_ init(name:stdin)}}} Sorter}
    ShowEntry}

  {Application.exit 0}
end

