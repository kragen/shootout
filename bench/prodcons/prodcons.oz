%%% $Id: prodcons.oz,v 1.1 2004-05-23 07:14:28 bfulgham Exp $
%%% http://dada.perl.it/shootout/
%%%
%%% contributed by Isaac Gouy

%%  Section 11.5 of the Oz Tutorial provides these
%%  implementations of Event and UnitBufferM and states:
%%  in Oz, it is very rare to write programs in the 
%%  (traditional) monitor style shown above. In general
%%  it is very awkward.
%%
%%  There's an extensive treatment of Oz concurrency in 
%%  the book 'Concepts, Techniques, and Models of Computer 
%%  Programming' - find it online with google.
%%
%%  Usage: start from command line with
%%     ozc -x prodcons.oz -o prodcons.oz.exe
%%     prodcons.oz.exe 100000

functor
import System Application

define

Produced
Consumed

class Event from BaseObject 
   prop locking
   attr f r
   meth init 
      X in f <- X r <- X
   end 
   meth put(I)
      X in lock @r=I|X r<-X end 
   end 
   meth get(?I)
      X in lock @f=I|X f<-X end {Wait I}
   end
   meth wait 
      {self get(_)}
   end 
   meth notify 
      {self put(unit)}
   end    
end


class UnitBufferM 
   attr item empty psignal csignal
   prop locking
   meth init 
      empty <- true 
      psignal <- {New Event init}
      csignal <- {New Event init}
   end 
   meth put(I)
      X in 
      lock 
         if @empty then 
            item <- I
            empty <- false 
            X = yes
            {@csignal notify}
         else X = no end 
      end 
      if X == no then 
         {@psignal wait}
         {self put(I)}
      end 
   end 
   meth get(I)
      X in 
      lock 
         if {Not @empty} then 
            I = @item
            empty <- true 
            {@psignal notify}
            X = yes
         else X = no end 
      end 
      if X == no then 
         {@csignal wait}
         {self get(I)}
      end 
   end 
end


proc {Producer N I B}
   if N > 0 then
      {B put(I)}
      %% {System.showInfo 'Produced '#I} %% just to check synchronization
      {Producer N-1 I+1 B}
   else Produced = {NewCell I} end
end 


proc {Consumer N I B}
   if N > 0 then
      {B get(I)}
      %% {System.showInfo 'Consumed '#I} %% just to check synchronization
      {Consumer N-1 I+1 B}
   else Consumed = {NewCell I} end
end 


in
   local Args N UB in
      [Args] = {Application.getArgs plain}
      N = {String.toInt Args}

      UB = {New UnitBufferM init}
      thread {Producer N 0 UB} end
      thread {Consumer N 0 UB} end

         %% Oz is a dataflow language.
         %% The main thread will wait until logic variables  
         %% Produced and Consumed have been given values
      {System.showInfo {Access Produced}#' '#{Access Consumed}}
   end
   {Application.exit 0}
end


