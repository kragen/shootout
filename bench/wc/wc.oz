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
    SPACE = &\040 in
    {Length {String.tokens {CompressWhiteSpace {LeftTrim LINE}} SPACE}}
  end

  fun {CountChars LINE PADDING}
    {Length LINE} + PADDING
  end

  fun {LeftTrim S}
    {List.dropWhile S Char.isSpace}
  end

  fun {CompressWhiteSpace S}
    {Compress S nil false Char.isSpace}
  end

  fun {Compress S A Flag P}
    case S of nil then A
    elseof H|T then
      if {P H} then
        if Flag then
          {Compress T A true P}
        else 
          {Compress T {List.append A [H]} true P}
        end
      else
        {Compress T {List.append A [H]} false P}
      end
    end
  end

  STDIN LINES WORDS CHARS

in
  STDIN = {New TextFile init(name:stdin)}

  [LINES WORDS CHARS] = {CountLinesWordsChars STDIN 0 0 0}
  {System.printInfo LINES#" "#WORDS#" "#CHARS#"\n"}

  {Application.exit 0}
end
