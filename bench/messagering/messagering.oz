% The Computer Language Benchmarks Game                             
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import Application System 

define
   fun {MessageRingThread Name Next}
      MessageList
      MessagePort = {Port.new MessageList}

      proc {Loop M|Ms}             % basic message loop
         if M > 0 then 
            {Next.take M-1}
            {Loop Ms}
         else
            {System.show Name}
            {Application.exit 0}   % exit without cleaning up
         end         
      end

      proc {Take M}
         {Port.send MessagePort M} 
      end
   in
      thread {Loop MessageList} end % spawn a MessageRingThread 
      ring(take: Take)              % let function Take be used elsewhere
   end


   NumberOfThreads = 503

   [Arg] = {Application.getArgs plain}
   NumberOfMessagesToSend = {String.toInt Arg}

   fun {MakeRing NumberOfThreads NextThread} 
      if NumberOfThreads > 0 then
         {MakeRing NumberOfThreads-1 {MessageRingThread NumberOfThreads NextThread}}
      else 
         NextThread
      end
   end


   % The unbound logic variable FirstThread is passed into recursive function 
   % MakeRing and the value returned by that function is then bound to variable 
   % FirstThread, closing the message thread ring.

   FirstThread = {MakeRing NumberOfThreads FirstThread}

in  
   {FirstThread.take NumberOfMessagesToSend}
end
