% ----------------------------------------------------------------------
% The Great Computer Language Shootout                              
% http://shootout.alioth.debian.org/                                
%                                                                   
% Attempt at a reasonably memory-efficient implementation which should:
%                                                                   
% * Handle 'large' files [~ >2MB] faster than existing version
% * Handle arbitrarily large files [~ >10MB] files without crashing
%   [unlike existing version which, since it uses stack unwinding to perform
%   its task, is very sensitive to the input file size]
%                                                                   
% Use made of code from 'Concepts, Techniques and Models of Computer
% Programming' [CTM] by P. van Roy, S. Haridi.
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

  %% General Purpose Stateful Stack [CTM implementation]

  fun {NewStack}
    C = {NewCell nil}

    proc {Push X} S in S = @C C := X|S end

    fun {Pop} S1 in
      S1 = @C
      case S1 of X|S then
        C := S
        X
      end
    end

    fun {IsEmpty} S in S = @C S == nil end
  in
    ops(push:Push pop:Pop isEmpty:IsEmpty)
  end

% ------------- %

  local
    LF = &\012 Lines = {NewStack} Spill = {NewCell nil}
  in
    proc {ProcessBuffer Buffer} Ys Yr in
      {String.token Buffer LF Ys Yr}
      {SplitAndPrint Yr}
      Spill := Ys
    end

    proc {FlushBuffer}
      {DumpSpill}      
    end

    proc {DumpLines}
      if {Lines.isEmpty} then skip
      else {System.showInfo {Lines.pop}} {DumpLines} 
      end
    end

    proc {DumpSpill}
      if @Spill \= nil then {System.showInfo @Spill} Spill := nil end
    end

    proc {SplitAndPrint Xs}
      case Xs of nil then skip
      else Ys Yr in
        {String.token Xs LF Ys Yr}

        %% Should really handle blank / LF-only lines here ...
        %% case Ys#Yr of nil#nil then ...
        %% [] nil#_ then ...
        %% [] _#nil then ...

        case Yr of nil then
          if {List.last Xs} \= LF then
            Spill := {List.append Ys @Spill}
          else
            {Lines.push Ys}
          end
          {DumpSpill}
          {DumpLines} 
        else
          {Lines.push Ys}          
          {SplitAndPrint Yr}
        end
      end 
    end

  end

% ------------- %

  proc {ReverseFile FILE BufferSize}

    proc {ReadBuffer RemainingBytes} BytesRead Buffer StartPos ToRead in
      if RemainingBytes < 1 then
        {FlushBuffer}
      else
        ToRead = if RemainingBytes < BufferSize then RemainingBytes else BufferSize end
        {FILE seek(whence:current offset:~ToRead)}
        {FILE tell(offset:StartPos)}
        {FILE read(list:Buffer size:ToRead len:BytesRead)}
        {FILE seek(whence:set offset:StartPos)}
        {ProcessBuffer Buffer}
        {ReadBuffer (RemainingBytes - BytesRead)}
      end
    end

    RemainingBytes
  in
    {FILE seek(whence:'end' offset:0)}
    {FILE tell(offset:RemainingBytes)}
    {ReadBuffer RemainingBytes}
  end

% ------------- %

  READSIZE = 4096

% ------------- %

in
  {ReverseFile {New TextFile_ init(name:stdin flags:[read text])} READSIZE}
  {Application.exit 0}
end

