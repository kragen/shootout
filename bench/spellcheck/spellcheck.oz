% ----------------------------------------------------------------------
% The Great Computer Language Shootout                              
% http://shootout.alioth.debian.org/                                
%                                                                   
% Contributed by Anthony Borla
% ----------------------------------------------------------------------

functor

import
  System Application Open(text file)

define
  class TextFile
    from Open.file Open.text
  end

  proc {LoadDictionary FILE DICTIONARY}
    case {FILE getS($)} of false then
      skip
    elseof WORD then
      {Dictionary.put DICTIONARY {String.toAtom WORD} true}
      {LoadDictionary FILE DICTIONARY}
    end
  end

  proc {CheckAgainstDictionary FILE DICTIONARY}
    case {FILE getS($)} of false then
      skip
    elseof WORD then
      if {Dictionary.member DICTIONARY {String.toAtom WORD}} \= true then
        {System.printInfo WORD}
        {System.printInfo "\n"}
      end
      {CheckAgainstDictionary FILE DICTIONARY}
    end
  end

in
  local DICTIONARY in
    {NewDictionary DICTIONARY}
    {LoadDictionary {New TextFile init(name:'Usr.Dict.Words')} DICTIONARY}
    {CheckAgainstDictionary {New TextFile init(name:stdin)} DICTIONARY}
  end

  {Application.exit 0}
end
