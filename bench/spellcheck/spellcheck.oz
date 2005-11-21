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
      if {Not {Dictionary.member DICTIONARY {String.toAtom WORD}}} then
        {System.printInfo WORD#"\n"}
      end
      {CheckAgainstDictionary FILE DICTIONARY}
    end
  end

  DICTIONARY

in
  {NewDictionary DICTIONARY}
  {LoadDictionary {New TextFile init(name:'Usr.Dict.Words')} DICTIONARY}
  {CheckAgainstDictionary {New TextFile init(name:stdin)} DICTIONARY}

  {Application.exit 0}
end
