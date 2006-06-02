% ----------------------------------------------------------------------
% The Great Computer Language Shootout                              
% http://shootout.alioth.debian.org/                                
%
% Contributed by Anthony Borla
% ----------------------------------------------------------------------

functor

import
  System(showInfo printInfo) Application(exit getArgs) Open(file text)

define

  class TextFile_
    from Open.file Open.text
  end

% ------------- %

  ITERATIONS = 50 LIMIT_SQR = 4.0

% ------------- %

  fun {CmdlNArg Nth Default} N Nt in
    try
      Nt = {String.toInt {Application.getArgs plain}.Nth}
      N = if Nt < Default then Default else Nt end
    catch error(...) then
      N = Default
    end
    N
  end

% ------------- %

  STDOUT = {New TextFile_ init(name:stdout)}

  N BitNum = {NewCell 0} ByteAcc = {NewCell 0}

  ZR = {NewCell 0.0} ZI = {NewCell 0.0} TR = {NewCell 0.0}
  TI = {NewCell 0.0} CR = {NewCell 0.0} CI = {NewCell 0.0}

  LIMIT_ADJ = {NewCell 1} PRINT = {NewCell false}

% ------------- %

in
  N = {CmdlNArg 1 1}

  {STDOUT putS({VirtualString.toString "P4\n" # N # " " # N})}

  for Y in 0..(N - 1) do
    for X in 0..(N - 1) do
      ZR := 0.0 ZI := 0.0 TR := 0.0 TI := 0.0

      CR := (2.0 * {IntToFloat X} / {IntToFloat N}) - 1.5
      CI := (2.0 * {IntToFloat Y} / {IntToFloat N}) - 1.0

      LIMIT_ADJ := 1

      for I in 0;(I < ITERATIONS andthen @LIMIT_ADJ \= 0);(I + 1) do
        TR := @ZR * @ZR - @ZI * @ZI + @CR
        TI := 2.0 * @ZR * @ZI + @CI ZR := @TR ZI := @TI

        if @ZR * @ZR + @ZI * @ZI > LIMIT_SQR then LIMIT_ADJ := 0 end
      end

      BitNum := @BitNum + 1
      ByteAcc := @ByteAcc * 2 + @LIMIT_ADJ

      if @BitNum == 8 then PRINT := true end

      if X == (N - 1) andthen @BitNum \= 8 then
        ByteAcc := @ByteAcc * {Number.pow 2 (8 - (N mod 8))}
        PRINT := true
      end

      if @PRINT then
        {STDOUT putC(@ByteAcc)}
        ByteAcc := 0 BitNum := 0 PRINT := false
      end

    end
  end

  {Application.exit 0}
end

