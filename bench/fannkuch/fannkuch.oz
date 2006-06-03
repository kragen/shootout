% ----------------------------------------------------------------------
% The Great Computer Language Shootout                              
% http://shootout.alioth.debian.org/                                
%                                                                   
% Contributed by Anthony Borla
% ----------------------------------------------------------------------

functor

import
  System(printInfo showInfo) Application(exit getArgs)

define

% ------------- %

  NEWLINE = "\n"

% ------------- %

  fun {Flips L}
    case L of 1|_ then
      0
    elseof N|_ then Lt Ld in
      {List.takeDrop L N Lt Ld}
      {Flips {List.append {List.reverse Lt} Ld}} + 1
    end
  end

% ------------- %

  fun {RotateLeft L}
    case L of nil then nil
    elseof X|Xr then
      {List.append Xr [X]}
    end
  end

% ------------- %

  proc {PrintPerm L}
    {ForAll L proc {$ X} {System.printInfo X} end}
    {System.printInfo NEWLINE}
  end

% ------------- %

  proc {ProcessPerm L}
    FlipCount = {Flips L}
  in
    if FlipCount > @MaxFlips then
      MaxFlips := FlipCount
    end

    if @PermN < 30 then
      {PrintPerm L}
      PermN := @PermN + 1
    end
  end

% ------------- %

  proc {Permutations L N I}
    if I < N then
      if N == 1 then
        {ProcessPerm L}
      else Lt Ld in
	{Permutations L (N - 1) 0}
        {List.takeDrop L N Lt Ld}
	{Permutations {List.append {RotateLeft Lt} Ld} N (I + 1)}
      end
    end
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

  PermN = {NewCell 0}  MaxFlips = {NewCell 0}  N

% ------------- %

in
  N = {CmdlNArg 1 1}

  {Permutations {List.number 1 N 1} N 0}
  {System.showInfo "Pfannkuchen(" # N # ") = " # @MaxFlips}

  {Application.exit 0}
end

