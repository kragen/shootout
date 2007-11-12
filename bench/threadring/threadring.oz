% The Computer Language Benchmarks Game                             
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import Application System 

define
   fun {NewThread Name Next}
      MessageList
      MessagePort = {Port.new MessageList}

      proc {Loop Token|Tokens}     % wait for list-head list-tail pattern to
         if Token > 0 then         % match and bind Token
            {Next.take Token-1}
            {Loop Tokens}
         else
            {System.show Name}
            {Application.exit 0}   % exit without cleaning up
         end         
      end

      proc {Take Token}
         {Port.send MessagePort Token} 
      end
   in
      thread {Loop MessageList} end % spawn a thread 
      newthread(take: Take)         % let function Take be used elsewhere
   end


   fun {NewRing NumberOfThreads}

      fun {MakeRing N NextThread} 
         if N > 0 then
            {MakeRing N-1 {NewThread N NextThread}}
         else 
            NextThread
         end
      end

      FirstThread
   in
      % The unbound logic variable FirstThread is passed into recursive 
      % function MakeRing and the value returned by that function is then
      % bound to variable FirstThread, closing the thread ring.

      FirstThread = {MakeRing NumberOfThreads FirstThread}
   end


   [Arg] = {Application.getArgs plain}

in  
   {{NewRing 503}.take {String.toInt Arg}}
end
