%%  Always 10000's times faster to append to the head of
%%  the list (and then Reverse) rather than traversing
%%  the entire list in each append before adding to tail.
%%
%%  http://shootout.alioth.debian.org/
%%
%%  contributed by Isaac Gouy
%%
%%  Usage: start from command line with
%%     ozc -x lists.oz -o lists.oz.exe
%%     lists.oz.exe 16

functor
import System Application

define
   L1 L2 L3
   
   fun {MoveLeftRight Li2 Li3}
      %% list|item requires list to be traversed to end
      %% before appending item. item|list always faster.
      %% {Reverse item|list} result same as list|item
      local H T in 
	 if Li2 == nil then Li2|[{Reverse Li3}]
	 else
	    H|T = Li2               %% take from left
	    {MoveLeftRight T H|Li3} %% append to left, reverse later
	 end
      end
   end

   proc {AssignL2L3 L}
      %% Factor out the assignment to allow simple reuse
      {Assign L2 {Nth L 1}}
      {Assign L3 {List.last L}}
   end
   
in
   local Args N Size in
      [Args] = {Application.getArgs plain}
      N = {String.toInt Args}
      Size = 10000
      {NewCell nil L1}{NewCell nil L2}{NewCell nil L3}    
      for I in 1..N do
	    %% Create L1
	 {Assign L1 {List.number 1 Size 1} }
	    %% Copy L1 to L2
	 {Assign L2 {List.take {Access L1} Size} }
	 {Assign L3 nil}

	    %% Move items from L2 to L3
	 {AssignL2L3 {MoveLeftRight {Access L2}{Access L3} }}
	    %% Move items from L3 to L2
	 {AssignL2L3 {Reverse {MoveLeftRight {Reverse {Access L3}}{Access L2}} }}
	    %% Reverse L1
	 {Assign L1 {Reverse {Access L1}}}
         if {Not {Nth {Access L1} 1} == Size andthen {Access L1} == {Access L2}} then
            {System.showInfo 'L1 != L2'}
         end
      end
      {System.showInfo {Length {Access L1}}}
   {Application.exit 0}
   end
end
