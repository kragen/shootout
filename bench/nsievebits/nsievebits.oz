% ----------------------------------------------------------------------
% The Great Computer Language Shootout                              
% http://shootout.alioth.debian.org/                                
%                                                                   
% Contributed by Anthony Borla
% ----------------------------------------------------------------------

functor

import
  System(showInfo) Application(exit getArgs)

define

% ------------- %

  SPACE = &\040

% ------------- %

  proc {CalcAndShowSieve Start Stop}
    Bits = {Sieve Start Stop}
    Output =
      "Primes up to" # {PadLeft {Int.toString Stop} 9 SPACE} #
      {PadLeft {Int.toString {BitArray.card Bits}} 9 SPACE}
  in
    {System.showInfo Output}
  end

% ------------- %

  local
    fun {Init I Stop Bits}
      if I =< Stop then {BitArray.set Bits I} {Init (I + 1) Stop Bits} else Bits end
    end

    fun {Sieve_ I J Start Stop Bits}
      if I > N then
        Bits
      else
        if J > Stop then
          {Sieve_ (I + 1) Start Start Stop Bits}
        else
          if {BitArray.test Bits J} then {ClearMultiples (J + J) J Stop Bits} end
          {Sieve_ I (J + 1) Start Stop Bits}
        end
      end
    end

    proc {ClearMultiples K J Stop Bits}
      if K =< Stop then {BitArray.clear Bits K} {ClearMultiples (K + J) J Stop Bits} end
    end

  in
    fun {Sieve Start Stop}
      {Sieve_ 1 Start Start Stop {Init Start Stop {BitArray.new Start Stop}}}
    end
  end

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

  fun {PadLeft S Padlen C} {List.append {MakePad S Padlen C} S} end

  fun {MakePad S Padlen C}
    L Reqlen = {List.length S} - Padlen
  in
    if Reqlen < 0 then
      L = {List.make {Number.abs Reqlen}}
      for I in L do I = C end
    else
      L = nil
    end
    L
  end

% ------------- %

  N Start = 2

% ------------- %

in
  N = {CmdlNArg 1 Start}

  {CalcAndShowSieve Start ({Number.pow 2 N} * 10000)}
  {CalcAndShowSieve Start ({Number.pow 2 (N - 1)} * 10000)}
  {CalcAndShowSieve Start ({Number.pow 2 (N - 2)} * 10000)}

  {Application.exit 0}
end

