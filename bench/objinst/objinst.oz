%%% $Id: objinst.oz,v 1.3 2004-06-26 10:37:12 ekarttun-guest Exp $
%%% http://dada.perl.it/shootout/
%%% 
%%% contributed by Isaac Gouy

%% Uses local variables within the Object Instantiation
%% loops. It might be quicker to create a Cell outside 
%% of the loop and use {Assign T {New Toggle init(true)}}
%%
%%  Usage: start from command line with
%%     ozc -x objinst.oz -o objinst.oz.exe
%%     objinst.oz.exe 1000000

functor
import System Application

define

class Toggle
   attr state: true
   meth state(V)
     V = @state
   end
   meth activate
      state <- {Not @state}
   end
   meth init(State)
      state <- State
   end
end

class NthToggle from Toggle
   attr trigger:0 count:0
   meth activate
      count <- @count + 1
      if @count >= @trigger then
     state <- {Not @state}
     count <- 0
      end
   end
   meth init(State Trigger)
      Toggle,init(State)
      trigger <- Trigger
      count <- 0
   end
end

in 
   local Args N T1 T2 in
      [Args] = {Application.getArgs plain}
      N = {String.toInt Args}

      T1 = {New Toggle init(true)}
      for I in 1..5 do
         local V in {T1 activate}{T1 state(V)}{System.show V} end
      end
      {System.showInfo ""}
      for I in 1..N do
         local T in T = {New Toggle init(true)} end
      end
   
      T2 = {New NthToggle init(true 3)}
      for I in 1..8 do
         local V in {T2 activate}{T2 state(V)}{System.show V} end
      end
   
      for I in 1..N do
         local T in T = {New NthToggle init(true 3)} end
      end
   end
   {Application.exit 0}
end
