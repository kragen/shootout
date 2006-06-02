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

  proc {ReverseFile FILE}
    case {FILE getS($)} of false then
      skip
    elseof LINE then
      {ReverseFile FILE}
      {System.showInfo LINE}
    end
  end

% ------------- %

in
  {ReverseFile {New TextFile_ init(name:stdin)}}
  {Application.exit 0}
end

