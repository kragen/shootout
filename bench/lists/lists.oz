functor
import
   System
   Application
define
   local Args N Size L1 L2 L3 Temp Result in
      {Application.getCmdArgs plain Args}
      if {List.length Args} \= 1 then 
         N = 1
      else
         {String.toInt Args.1 N}
      end

      Size = 10000

      L1 = {NewCell nil}
      L2 = {NewCell nil}
      L3 = {NewCell nil}
      Temp = {NewCell nil}
      Result = {NewCell 0}

      proc {MyMain Q}
%%
%first create a list (L1) of integers from 1 through SIZE (SIZE is currently defined as 10000).

{Assign L1 {List.number 1 Size 1}}

%copy L1 to L2 (can use any builtin list copy function, if available) 

{Assign L2 {Access L1}}

%remove each individual item from left side (head) of L2 and append to right side (tail)
%  of L3 (preserving order). (L2 should be emptied by one item at a time as that item is
%  appended to L3).

{For 1 (Size - 1) 1
  proc {$ N} 
     {Assign Temp {List.nth {Access L2} 1}}
     {Assign L2 {List.drop {Access L2} 1}}
     {Assign L3 {List.append {Access L3} {Access Temp}|nil}}
  end} 
%remove each individual item from right side (tail) of L3 and append to right side (tail)
%  of L2 (reversing list). (L3 should be emptied by one item at a time as that item is
%  appended to L2). 

{For 1 (Size - 1) 1
  proc {$ N} 
     {Assign Temp {List.last {Access L3}}}
     {Assign L3 {List.take {Access L3} {List.length {Access L3}} - 1}}
     {Assign L2 {List.append {Access L2} {Access Temp}|nil}}
  end} 

%reverse L1 (preferably in place) (can use any builtin function for this, if available).

{Assign L1 {List.reverse {Access L1} $}}

%check that first item of L1 is now == SIZE. 

if {Value.'\\=' {List.nth {Access L1} 1} Size} then
    % {System.showInfo "Equal!"}
% else
    {Assign Result 0}
end


%and compare L1 and L2 for equality and return length of L1 (which should be equal to SIZE). `

if {Value.'==' {Access L1} {Access L2}} then
    {Assign Result {List.length {Access L1}}}
else
    {Assign Result 0}
end
%%
      end 

      {For 1 N 1 MyMain}

      {System.showInfo {Access Result}}
      {Application.exit 0}
   end
end
