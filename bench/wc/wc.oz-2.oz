% ----------------------------------------------------------------------
% The Great Computer Language Shootout                              
% http://shootout.alioth.debian.org/                                
%
% An attempt at a faster [approx. 50% better] implementation via:
%
% * Utilising 4K read buffer [rather than reading line-by-line]
% * Computing results in a single traversal of the input data [rather
%   than multiply traversing, or otherwise manipulating, input data]
%
% Contributed by Anthony Borla
% ----------------------------------------------------------------------

functor

import
  System(showInfo) Application(exit) Open(text file)

define

% ------------- %

  LF = &\012 READSIZE = 4096

% ------------- %

  class TextFile_
    from Open.file Open.text
  end

% ------------- %

  fun {CountLinesWordsChars FILE BufferSize}

    Lines = {NewCell 0} Words = {NewCell 0} Chars = {NewCell 0} RemainingBytes

    % ------------- %

    proc {ReadBuffer RemainingBytes}
      BytesRead Buffer ToRead
    in
      if RemainingBytes < 1 then
        skip
      else
        ToRead = if RemainingBytes < BufferSize then RemainingBytes else BufferSize end
        {FILE read(list:Buffer size:ToRead len:BytesRead)}
        {ProcessBuffer Buffer}
        {ReadBuffer (RemainingBytes - BytesRead)}
      end
    end

    % ------------- %

    local

      CountingWordStatus = {NewCell false} FirstCall = {NewCell true}

      % ------------- %

      proc {CheckBuffer_ X Xr CountingWord}
        Chars := @Chars + 1
        if X == LF then Lines := @Lines + 1 end

        if CountingWord then
          if {Char.isSpace X} then
            {ProcessBuffer_ Xr false}
          else
            {ProcessBuffer_ Xr CountingWord}
          end
        else
          if {Not {Char.isSpace X}} then
            Words := @Words + 1
            {ProcessBuffer_ Xr true}
          else
            {ProcessBuffer_ Xr CountingWord}
          end
        end
      end

      % ------------- %

      proc {ProcessBuffer_ Buffer CountingWord}
        case Buffer of nil then
          CountingWordStatus := CountingWord
        elseof X|Xr then
          {CheckBuffer_ X Xr CountingWord}
        end
      end

      % ------------- %

    in

      proc {ProcessBuffer Buffer}
        X|Xr = Buffer
      in
        if @FirstCall then CountingWord in
          FirstCall := false
          if (CountingWord = {Not {Char.isSpace X}}) then Words := @Words + 1 end
          {CheckBuffer_ X Xr CountingWord}
        else
          {CheckBuffer_ X Xr @CountingWordStatus}
        end
      end

    end

    % ------------- %

  in
    {FILE seek(whence:'end' offset:0)}
    {FILE tell(offset:RemainingBytes)}
    {FILE seek(whence:set offset:0)}
    {ReadBuffer RemainingBytes}

    [@Lines @Words @Chars]
  end

% ------------- %

  LINES WORDS CHARS

% ------------- %

in
  [LINES WORDS CHARS] =
    {CountLinesWordsChars
      {New TextFile_ init(name:stdin flags:[read text])} READSIZE}

  {System.showInfo LINES # " " # WORDS # " " # CHARS}

  {Application.exit 0}
end

