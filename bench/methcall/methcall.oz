%%% $Id: methcall.oz,v 1.2 2004-06-26 10:37:12 ekarttun-guest Exp $
%%% http://dada.perl.it/shootout/
%%% 
%%% contributed by Isaac Gouy

%%  Usage: start from command line with
%%     ozc -x methcall.oz -o methcall.oz.exe
%%     methcall.oz.exe 1000000

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

fun {MethodSends N T}
   local V in
      if N==0 then {T state(V)} V
      else
     {T activate}{T state(V)}
     {MethodSends N-1 T}
      end
   end
end

in 
   local Args N in
      [Args] = {Application.getArgs plain}
      N = {String.toInt Args}
      {System.show {MethodSends N {New Toggle init(true)}}}
      {System.show {MethodSends N {New NthToggle init(true 3)}}}   
   end
   {Application.exit 0}
end
