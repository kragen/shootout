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

  SPACE = &\040  NEWLINE_LENGTH = 1

% ------------- %

  class TextFile_
    from Open.file Open.text
  end

% ------------- %

  fun {CountLinesWordsChars FILE}

    fun {CountLinesWordsChars_ LINES WORDS CHARS}
      case {FILE getS($)} of false then
        [LINES WORDS CHARS]
      elseof LINE then
        {CountLinesWordsChars_ (LINES + 1) (WORDS + {CountWords LINE}) (CHARS + {CountChars LINE NEWLINE_LENGTH})}
      end
    end

    % ------------- %

    fun {CountWords LINE}
      {Length {String.tokens {CompressWhiteSpace {LeftTrim LINE}} SPACE}}
    end

    % ------------- %

    fun {CountChars LINE PADDING}
      {Length LINE} + PADDING
    end

  in
    {CountLinesWordsChars_ 0 0 0}
  end

% ------------- %

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

% ------------- %

  LINES WORDS CHARS

% ------------- %

in
  [LINES WORDS CHARS] = {CountLinesWordsChars {New TextFile_ init(name:stdin)}}
  {System.showInfo LINES # " " # WORDS # " " # CHARS}
  {Application.exit 0}
end

