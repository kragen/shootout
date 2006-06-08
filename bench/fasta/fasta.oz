% ----------------------------------------------------------------------
% The Great Computer Language Shootout                              
% http://shootout.alioth.debian.org/                                
%                                                                   
% IUB and HOMOSAPIEN data encoded as lists of tuples. This approach is
% much slower than encoding data as records [alternate code shown within
% comment markers] but is used because of the need to keep physical
% order for the building of cumulative frequency tables.
%
% Contributed by Anthony Borla
% ----------------------------------------------------------------------

functor

import
  System(showInfo) Application(exit getArgs) Open(file text)

define

  class TextFile_
    from Open.file Open.text
  end

% ------------- %

  ALU = 
    {ByteString.make
      {VirtualString.toString
        "GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG" #
        "GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA" #
        "CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT" #
        "ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA" #
        "GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG" #
        "AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC" #
        "AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA"}}

%
%  IUB =
%    freqs(&a:0.27 &c:0.12 &g:0.12 &t:0.27 &B:0.02
%          &D:0.02 &H:0.02 &K:0.02 &M:0.02 &N:0.02
%          &R:0.02 &S:0.02 &V:0.02 &W:0.02 &Y:0.02)
%
%
%  HOMOSAPIEN =
%    freqs(&a:0.3029549426680 &c:0.1979883004921
%          &g:0.1975473066391 &t:0.3015094502008)
%

% ------------- %

%
%  fun {MakeCumulativeTable FrequencyTable}
%    CumulativeValue = {NewCell 0.0}
%    CumulativeTable = {Record.clone FrequencyTable} 
%  in
%    for Key in {Arity FrequencyTable} do
%      CumulativeValue := @CumulativeValue + FrequencyTable.Key
%      CumulativeTable.Key = @CumulativeValue
%    end
%    CumulativeTable
%  end
%

  IUB = [&a#0.27 &c#0.12 &g#0.12 &t#0.27 &B#0.02
         &D#0.02 &H#0.02 &K#0.02 &M#0.02 &N#0.02
         &R#0.02 &S#0.02 &V#0.02 &W#0.02 &Y#0.02]

  HOMOSAPIEN = [&a#0.3029549426680 &c#0.1979883004921
                &g#0.1975473066391 &t#0.3015094502008]

% ------------- %

  fun {MakeCumulativeTable FrequencyTable}
    CumulativeValue = {NewCell 0.0}
    CumulativeTable = {NewCell nil}
  in
    for Key#Value in FrequencyTable do
      CumulativeValue := @CumulativeValue + Value
      CumulativeTable := Key#@CumulativeValue|@CumulativeTable
    end
    {List.reverse @CumulativeTable}
  end

% ------------- %

  fun {NewFasta OUT}

    SEGMARKER = ">"  LF = &\012

    % ------------- %

    local
      Random = {NewRandom 42}
    in
      fun {SelectRandom CumulativeTable}
        RValue = {Random.next 1.0}
      in
        %
        % for Key in {Arity CumulativeTable} return:RETURN do
        %   if RValue =< CumulativeTable.Key then {RETURN Key} end
        % end
        %

        for Key#Value in CumulativeTable return:RETURN do
          if RValue =< Value then {RETURN Key} end
        end

      end
    end

    % ------------- %

    proc {RepeatFasta Id Desc N_ Sequence LineLength}
      K = {NewCell 0}  M = {NewCell 0}  SeqLen = {ByteString.length Sequence}
    in
      {OUT putS({VirtualString.toString SEGMARKER # Id # " " # Desc})}

      for N in N_;(N > 0);(N - LineLength) do
        M := if N < LineLength then N else LineLength end
        for I in 0;(I < @M);(I + 1) do
          if @K == SeqLen then K := 0 end
          {OUT putC({ByteString.get Sequence @K})}
          K := @K + 1 
        end
        {OUT putC(LF)}
      end
    end

    % ------------- %

    proc {RandomFasta Id Desc N_ CumulativeTable LineLength}
      M = {NewCell 0}
    in
      {OUT putS({VirtualString.toString SEGMARKER # Id # " " # Desc})}

      for N in N_;(N > 0);(N - LineLength) do
        M := if N < LineLength then N else LineLength end
        for I in 0;(I < @M);(I + 1) do
          {OUT putC({SelectRandom CumulativeTable})}
        end
        {OUT putC(LF)}
      end
    end

    % ------------- %

  in
    ops(randomFasta:RandomFasta repeatFasta:RepeatFasta)
  end

% ------------- %

  fun {NewRandom Seed}
    local
      IA = 3877 IC = 29573 IM = 139968
      Last = {NewCell Seed}
    in
      fun {Next Max}
        Last := (@Last * IA + IC) mod IM
        Max * {Int.toFloat @Last} / {Int.toFloat IM}
      end
    end
  in
    ops(next:Next)
  end

% ------------- %

  fun {CmdlNArg Nth Default}
    N Nt in
    try
      Nt = {String.toInt {Application.getArgs plain}.Nth}
      N = if Nt < Default then Default else Nt end
    catch error(...) then
      N = Default
    end
    N
  end

% ------------- %

  N Fasta = {NewFasta {New TextFile_ init(name:stdout)}}

% ------------- %

in
  N = {CmdlNArg 1 1}

  {Fasta.repeatFasta "ONE" "Homo sapiens alu" (N * 2) ALU 60}

  {Fasta.randomFasta "TWO" "IUB ambiguity codes" (N * 3)
    {MakeCumulativeTable IUB} 60}

  {Fasta.randomFasta "THREE" "Homo sapiens frequency" (N * 5)
    {MakeCumulativeTable HOMOSAPIEN} 60}

  {Application.exit 0}
end

