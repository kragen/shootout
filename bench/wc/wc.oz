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
  class TextFile
    from Open.file Open.text
  end

  fun {CountLinesWordsChars FILE LINES WORDS CHARS}
    case {FILE getS($)} of false then
      [LINES WORDS CHARS]
    elseof LINE then
      {CountLinesWordsChars FILE (LINES + 1) (WORDS + {CountWords LINE}) (CHARS + {CountChars LINE 1})}
    end
  end

  fun {CountWords LINE}
    {Length {String.tokens {CompressWhiteSpace {LeftTrim LINE}} &\040}}
  end

  fun {CountChars LINE PADDING}
    {Length LINE} + PADDING
  end

  fun {LeftTrim S}
    {List.dropWhile S Char.isSpace}
  end

  fun {CompressWhiteSpace S}
    {Compress S false Char.isSpace}
  end

  fun {Compress S Flag P}
    case S of nil then nil
    elseof H|T then Pt in
      if (Pt = {P H}) andthen Flag then
        {Compress T true P}
      else
        H|{Compress T Pt P}
      end
    end
  end

  STDIN LINES WORDS CHARS
in
  STDIN = {New TextFile init(name:stdin)}

  [LINES WORDS CHARS] = {CountLinesWordsChars STDIN 0 0 0}
  {System.showInfo LINES#" "#WORDS#" "#CHARS}

  {Application.exit 0}
end
