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
    Count = {Sieve Start Stop}
    Output =
      "Primes up to" # {PadLeft {Int.toString Stop} 9 SPACE} #
      {PadLeft {Int.toString Count} 9 SPACE}
  in
    {System.showInfo Output}
  end

% ------------- %

  local
    fun {Sieve_ I J Start Stop Count Entries}
      if I > N then
        Count
      else
        if J > Stop then
          {Sieve_ (I + 1) Start Start Stop Count Entries}
        else
          if {Array.get Entries J} then
            {Array.put Entries J false} {ClearMultiples (J + J) J Stop Entries}
            {Sieve_ I (J + 1) Start Stop (Count + 1) Entries}
          else
            {Sieve_ I (J + 1) Start Stop Count Entries}
          end
        end
      end
    end

    proc {ClearMultiples K J Stop Entries}
      if K =< Stop then {Array.put Entries K false} {ClearMultiples (K + J) J Stop Entries} end
    end

  in
    fun {Sieve Start Stop}
      {Sieve_ 1 Start Start Stop 0 {Array.new Start Stop true}}
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

