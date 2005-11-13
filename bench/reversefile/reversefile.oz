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

  proc {ReverseFile FILE}
    case {FILE getS($)} of false then
      skip
    elseof LINE then
      {ReverseFile FILE}
      {System.printInfo LINE}
      {System.printInfo "\n"}
    end
  end

in
  {ReverseFile {New TextFile init(name:stdin)}}
  {Application.exit 0}
end
