% ----------------------------------------------------------------------
% The Great Computer Language Shootout                              
% http://shootout.alioth.debian.org/                                
%                                                                   
% Contributed by Anthony Borla
% ----------------------------------------------------------------------

functor

import
  System Application

define Start = 2 N

  proc {CalcAndShowSieve Start Stop}
    local Bits Output SPACE = 32 in

      Bits = {BitArray.new Start Stop}
      {Init Start Stop Bits}
      {Sieve 1 Start Start Stop Bits}

      Output =
        "Primes up to"#    
        {JustifyRight {Int.toString Stop} SPACE 9}#
        {JustifyRight {Int.toString {BitArray.card Bits}} SPACE 9}#
        "\n"

      {System.printInfo Output}
    end
  end

  proc {Init I Stop Bits}
    if I =< Stop then {BitArray.set Bits I} {Init (I + 1) Stop Bits} end
  end

  proc {Sieve I J Start Stop Bits}
    if I > N then
      skip
    else
      if J > Stop then
        {Sieve (I + 1) Start Start Stop Bits}
      else
        if {BitArray.test Bits J} then {ClearMultiples (J + J) J Stop Bits} end
        {Sieve I (J + 1) Start Stop Bits}
      end
    end
  end

  proc {ClearMultiples K J Stop Bits}
    if K =< Stop then {BitArray.clear Bits K} {ClearMultiples (K + J) J Stop Bits} end
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
