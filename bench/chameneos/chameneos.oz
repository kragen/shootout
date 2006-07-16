% ----------------------------------------------------------------------
% The Great Computer Language Shootout                              
% http://shootout.alioth.debian.org/                                
%                                                                   
% Another one of my Oz concurrency 'explorations', this implementation
% [the first of several, all of which I hope will be improvements :)]
% is based on the MzScheme version which uses 'synchronous channels' to
% communicate between threads. Whilst this approach isn't particularly
% fast I quite like it because it is a very simple design which is
% readily comprehendable, and easily implemented with relatively
% little code.
%
% The current version uses a combination of Oz 'ports' and dataflow
% variables to mimic 'synchronous channels', and like the MzScheme
% version, isn't particularly fast.
% 
% Please forgive any idiomatic blunders or other language misuses. I
% will need to reread CTM ['Concepts, Techniques and Models of Computer
% Programming' by P. van Roy, S. Haridi] a few more times to really get
% the hang of Oz-style concurrency :) !
%
% Contributed by Anthony Borla
% ----------------------------------------------------------------------

functor

import
  System(showInfo show) Application(exit getArgs)

define

% ------------- %

  fun {Complement This That}
    case This # That
      of blue # blue then blue
      [] blue # red then yellow
      [] blue # yellow then red
      [] red # blue then yellow
      [] red # red then red
      [] red # yellow then blue
      [] yellow # blue then red
      [] yellow # red then blue
      [] yellow # yellow then yellow
    end
  end

% ------------- %

  proc {Meeting MeetingQueue N Counter}
    thread
      proc {Meeting_ N}
        if N == 0 then LQ in
          meeting(LQ _) = {MeetingQueue.delete}
          {LQ.insert nil}
          {Meeting_ 0}
        else LQ1 LQ2 C1 C2 in
          meeting(LQ1 C1) = {MeetingQueue.delete}
          meeting(LQ2 C2) = {MeetingQueue.delete}
          {LQ1.insert C2}
          {LQ2.insert C1}
          {Meeting_ (N - 1)}
        end
      end
    in
      {Counter.increment}
      {Meeting_ N}
      {Counter.decrement}
    end
  end

% ------------- %

  proc {Chameneos Colour MeetingQueue ResultQueue Counter}
    thread
      LQ = {NewSyncQueue}

      proc {Chameneos_ Colour OtherColour Meetings}
        {MeetingQueue.insert meeting(LQ Colour)}
        if OtherColour == nil then
          {ResultQueue.insert Meetings}
        else
          {Chameneos_ {Complement Colour OtherColour} {LQ.delete} (Meetings + 1)}
        end
      end
    in
      {Counter.increment}
      {Chameneos_ Colour Colour ~1}
      {Counter.decrement}
    end
  end

% ------------- %

  proc {WaitForThreadExit Parent Counter}
    fun {Skip} nil end
  in
    for _ in {Skip};({Counter.current} > 0);{Skip} do
      {Thread.preempt Parent}
    end  
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

  %% Port-based Concurrent Queue [modified CTM implementation]

  fun {NewPortQueue}
    Given GivePort = {NewPort Given}
    Taken TakePort = {NewPort Taken}
  in
    thread Given = Taken end
    ops(insert:proc {$ X} {Send GivePort X} end
        delete:proc {$ X} {Send TakePort X} end)
  end

  %% Synchronous Concurrent Queue [implemented as described in CTM text]

  fun {NewSyncQueue}
    C = {NewPortQueue}

    proc {Insert X}
      {Wait X}
      {C.insert X}
    end

    fun {Delete}
      X
    in
      {C.delete X}
      {Wait X}
      X
    end
  in
    ops(insert:Insert delete:Delete)
  end

% ------------- %

  SetOfChameneos = [blue red yellow blue]

  MeetingQueue = {NewSyncQueue}  ResultQueue = {NewSyncQueue}  Counter = {NewCounter}

  N

% ------------- %

in
  N = {CmdlNArg 1 1}

  {Meeting MeetingQueue N Counter}

  for I in SetOfChameneos do
    {Chameneos I MeetingQueue ResultQueue Counter}
  end

  {WaitForThreadExit {Thread.this} Counter}

  {System.showInfo
    {List.foldL SetOfChameneos fun {$ A _} (A + {ResultQueue.delete}) end 0}}

  {Application.exit 0}
end

