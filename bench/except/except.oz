%%% $Id: except.oz,v 1.1 2004-05-23 06:34:14 bfulgham Exp $
%%% http://dada.perl.it/shootout/
%%% 
%%% contributed by Isaac Gouy

%%  Usage: start from command line with
%%     ozc -x except.oz -o except.oz.exe
%%     except.oz.exe 2000

functor
import System Application

define

   LoCount
   HiCount
   
   proc {Blowup N}
      if N mod 2 == 0 then raise loException() end
      else raise hiException() end end
   end

   proc {LoFun N}
      try {Blowup N} catch
     loException then {Assign LoCount {Access LoCount}+1}
      end
   end

   proc {HiFun N}
      try {LoFun N} catch
     hiException then {Assign HiCount {Access HiCount}+1}
      end
   end

   proc {SomeFun N}
      if N > 0 then
     try {HiFun N} catch
        loException then {System.showInfo 'loException should not get here'}
        [] hiException then {System.showInfo 'hiException should not get here'}
     end
     {SomeFun N-1}
      end
   end
in
   local Args N in
      [Args] = {Application.getArgs plain}
      N = {String.toInt Args}

      LoCount = {NewCell 0}
      HiCount = {NewCell 0}
      {SomeFun N}

      {System.printInfo "Exceptions: HI="}
      {System.printInfo {Access HiCount}}
      {System.printInfo " / LO="}
      {System.showInfo {Access LoCount}}
   end
   {Application.exit 0}
end
