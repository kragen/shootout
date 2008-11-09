% The Computer Language Benchmarks Game
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import Application System

define
   [Arg] = {Application.getArgs plain}
   N = {String.toInt Arg}

   Min_ = 4
   Max_ = {Max Min_+2 N}
   StretchDepth = Max_ + 1
   LongLivedTree 

   fun {NewTree I D}
      if D == 0 then
         tree(I nil nil)
      else 
         tree(I {NewTree 2*I-1 D-1} {NewTree 2*I D-1})
      end
   end

   fun {ItemCheck T}
      if T == nil then 0 
      else tree(I L R) = T in I + {ItemCheck L} - {ItemCheck R} end
   end

   proc {ShowItemCheck S D T}
      {System.showInfo S # D # "\t check: " # {ItemCheck T}}
   end

   proc {ShowCheck I D Check}
      {System.showInfo 2*I # "\t trees of depth " # D # "\t check: " # Check}
   end

in      
   {ShowItemCheck "stretch tree of depth " StretchDepth {NewTree 0 StretchDepth}}
   LongLivedTree = {NewTree 0 Max_}

   for D in Min_; D=<Max_; D+2 do 
      N = {Pow 2 Max_-D+Min_}
      Check = {NewCell 0}
   in
      for I in 1..N do
         Check := @Check + {ItemCheck {NewTree I D}} + {ItemCheck {NewTree ~I D}}
      end
      {ShowCheck N D @Check}
   end

   {ShowItemCheck "long lived tree of depth " Max_ LongLivedTree}
   {Application.exit 0}   
end
