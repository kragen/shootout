% The Computer Language Shootout                              
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import Application System 

define
   fun {NewIncrementer Next}
      MessageList
      MessagePort = {Port.new MessageList}

      proc {Loop J|Js S}
         if Next \= nil then 
            {Next.take J}
            {Loop Js 0}

         else
            Sum = S+J
         in
            if Sum < Final then 
               {Loop Js Sum}  
            else
               {System.show Sum}
               {Application.exit 0}   % exit without cleaning up
            end
         end         
      end

      proc {Take J}
         {Port.send MessagePort J+1} 
      end
   in
      thread {Loop MessageList 0} end
      incrementer(take: Take)
   end


   [Arg] = {Application.getArgs plain}
   N = {String.toInt Arg}

   NThreads = 500
   Final = NThreads * N
 
   fun {ThreadChain N NextThread} 
      if N > 0 then
         {ThreadChain N-1 {NewIncrementer NextThread}}
      else 
         NextThread
      end
   end

   FirstThread = {ThreadChain NThreads nil}

in  
   for I in 1..N do {FirstThread.take 0} end
end
