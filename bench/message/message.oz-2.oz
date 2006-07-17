% ----------------------------------------------------------------------
% The Great Computer Language Shootout                              
% http://shootout.alioth.debian.org/                                
%                                                                   
% I still don't quite completely grok dataflow variables [or streams and
% ports for that matter :)], so have opted for a 'Java'ish ? approach.
% Whilst I think it's somewhat clunky, it seems fairly fast and
% reasonably efficient. I look forward to any constructive feedback.
%
% Contributed by Anthony Borla
% ----------------------------------------------------------------------

functor

import
  System(showInfo) Application(exit getArgs)

define

% ------------- %

  fun {NewBLT Counter IsLast Next}

    EXIT = ~1  MailBox = {NewQueue}  Total = {NewCell 0}

    % ------------- %

    fun {Get}
      {MailBox.delete}
    end

    proc {Put Message}
      {MailBox.insert Message}
    end

    proc {Flush}
      {MailBox.insert EXIT}
    end

    % ------------- %

    proc {WaitForThreadExit Parent}
      fun {Skip} nil end
    in
      % A 'not-so-busy' wait by parent thread for subordinate threads to terminate. Could
      % have used the 'Time.repeat' class to do this [perhaps more efficiently], but this
      % approach was deemed quite straightforward
      for _ in {Skip};({Counter.current} > 0);{Skip} do
        {Thread.preempt Parent}
      end  
    end

    % ------------- %

    proc {Run}
      for Message in {Get};{Get} break:BREAK do
        if Message == EXIT then
          % Decrement 'counter' cell to indicate thread creation          
          {Counter.decrement}

          % Propogate 'exit' message so other threads terminate
          {Next.put Message}

          % Leave loop, so terminating thread
          {BREAK}
        else
          if IsLast then
            Total := @Total + Message
          else
            {Next.put (Message + 1)}
          end
        end   
      end

      % All done, show sum
      if IsLast then
        {System.showInfo @Total}
      end
    end

    % ------------- %

  in
    % Incement 'counter' cell to indicate thread creation
    {Counter.increment}

    % Start the thread
    thread {Run} end

    % Return set of thread management operations
    ops(get:Get put:Put flush:Flush waitForThreadExit:WaitForThreadExit)
  end

% ------------- %

  fun {MakeBLTS N Counter}
    First

    fun {MakeBLTS_ N BLT}
      if N == 0 then
        First = BLT
        BLT
      else
        {MakeBLTS_ (N - 1) {NewBLT Counter false BLT}}
      end
    end

  in
    {MakeBLTS_ N {NewBLT Counter true First}}
  end

% ------------- %

  fun {NewCounter}
    Count = {NewCell 0}  Lock = {NewLock}

    proc {Increment} lock Lock then Count := @Count + 1 end end
    proc {Decrement} lock Lock then Count := @Count - 1 end end
    fun {Current} lock Lock then @Count end end

  in
    ops(increment:Increment decrement:Decrement current:Current)
  end

% ------------- %

  fun {CmdlNArg Nth Default}
    N Nt in
    try
      Nt = {String.toInt {Application.getArgs plain}.Nth}
      N = if Nt < Default then Default else Nt end
    catch error(...) then
      N = Default
    end
    N
  end

% ------------- %

  %% General Purpose Concurrent Queue [CTM implementation]

  fun {NewQueue}
    X C = {NewCell q(0 X X)}

    proc {Insert X}
      N S E1 N1
    in
      {Exchange C q(N S X|E1) q(N1 S E1)}
      N1 = N + 1
    end

    fun {Delete}
      N S1 E N1 X
    in
      {Exchange C q(N X|S1 E) q(N1 S1 E)}
      N1 = N - 1
      X
    end
  in
    queue(insert:Insert delete:Delete)
  end

% ------------- %

  N BLTS

% ------------- %

in
  N = {CmdlNArg 1 1}

  % Create set of 'bounded linked thread's [hence, BLTS :)]
  BLTS = {MakeBLTS 500 {NewCounter}}

  % Enque requisite number of messages on first thread
  for I in 1..N do
    {BLTS.put 0}
  end

  % Enque 'exit' message so thread termination process commences
  {BLTS.flush}

  % Wait here until all subordinate threads terminate
  {BLTS.waitForThreadExit {Thread.this}}

  {Application.exit 0}
end

