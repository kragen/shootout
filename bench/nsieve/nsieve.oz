% ----------------------------------------------------------------------
% The Computer Language Shootout                              
% http://shootout.alioth.debian.org/                                
%                                                                   
% Contributed by Anthony Borla
% ----------------------------------------------------------------------

functor

import
  System Application

define Start = 2 N

  proc {CalcAndShowSieve Start Stop}
    local Entries Count Output SPACE = 32 in

      Entries = {Array.new Start Stop true}
      Count = {Sieve 1 Start Start Stop 0 Entries}

      Output =
        "Primes up to"#    
        {JustifyRight {Int.toString Stop} SPACE 9}#
        {JustifyRight {Int.toString Count} SPACE 9}#
        "\n"

      {System.printInfo Output}
    end
  end

  fun {Sieve I J Start Stop Count Entries}
    if I > N then
      Count
    else
      if J > Stop then
        {Sieve (I + 1) Start Start Stop Count Entries}
      else
        if {Array.get Entries J} then
          {Array.put Entries J false} {ClearMultiples (J + J) J Stop Entries}
          {Sieve I (J + 1) Start Stop (Count + 1) Entries}
        else
          {Sieve I (J + 1) Start Stop Count Entries}
        end
      end
    end
  end

  proc {ClearMultiples K J Stop Entries}
    if K =< Stop then {Array.put Entries K false} {ClearMultiples (K + J) J Stop Entries} end
  end

  fun {CmdlNArg Nth Default}
    local Nt N in
      try
        Nt = {String.toInt {Application.getArgs plain}.Nth}
        N = if Nt < Default then Default else Nt end
      catch error(...) then
        N = Default
      end
      N
    end
  end

  fun {FillList S C}
    for I in S do I = C end
    S
  end

  fun {JustifyRight S C N}
    {Append {FillList {MakeList (N - {Length S})} C} S}
  end

in
  N = {CmdlNArg 1 Start}

  {CalcAndShowSieve Start ({Number.pow 2 N} * 10000)}
  {CalcAndShowSieve Start ({Number.pow 2 (N - 1)} * 10000)}
  {CalcAndShowSieve Start ({Number.pow 2 (N - 2)} * 10000)}

  {Application.exit 0}
end
