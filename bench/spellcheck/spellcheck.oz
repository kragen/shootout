% ----------------------------------------------------------------------
% The Great Computer Language Shootout                              
% http://shootout.alioth.debian.org/                                
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

  proc {LoadDictionary FILE DICTIONARY}
    case {FILE getS($)} of false then
      skip
    elseof WORD then
      {Dictionary.put DICTIONARY {String.toAtom WORD} true}
      {LoadDictionary FILE DICTIONARY}
    end
  end

% ------------- %

  proc {CheckAgainstDictionary FILE DICTIONARY}
    case {FILE getS($)} of false then
      skip
    elseof WORD then
      if {Not {Dictionary.member DICTIONARY {String.toAtom WORD}}} then
        {System.showInfo WORD}
      end
      {CheckAgainstDictionary FILE DICTIONARY}
    end
  end

% ------------- %

  DICTIONARY = {NewDictionary}

% ------------- %

in
  {LoadDictionary {New TextFile_ init(name:'Usr.Dict.Words')} DICTIONARY}
  {CheckAgainstDictionary {New TextFile_ init(name:stdin)} DICTIONARY}
  {Application.exit 0}
end

