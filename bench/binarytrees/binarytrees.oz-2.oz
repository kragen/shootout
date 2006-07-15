% The Computer Language Shootout                              
% http://shootout.alioth.debian.org/    
% contributed by Isaac Gouy

functor
import Application System

define
   [Arg] = {Application.getArgs plain}
   N = {String.toInt Arg}

   Min0 = 4
   Max0 = {Max Min0+2 N}
   StretchDepth = Max0 + 1
   LongLivedTree 

   fun {NewTree I D}
      if D == 0 then nil 
      else 
         tree(I {NewTree 2*I-1 D-1} {NewTree 2*I D-1})
      end
   end

   fun {ItemCheck T}
      if T == nil then 0 
      else tree(I L R) = T in I + {ItemCheck L} - {ItemCheck R} end
   end

   fun {SumLoop N D Sum}
      Check1 = {ItemCheck {NewTree N D}}
      Check2 = {ItemCheck {NewTree ~1*N D}}
   in
      if N > 0 then {SumLoop N-1 D Sum+Check1+Check2} else Sum end
   end

   proc {DepthLoop D M}
      N = {Pow 2 M-D+Min0}

      proc {ShowCheck I D Check}
         {System.showInfo 2*I # "\t trees of depth " # D # "\t check: " # Check}
      end
   in
     if D =< M then
         {ShowCheck N D {SumLoop N D 0} }
         {DepthLoop D+2 M}
      end
   end

   proc {ShowItemCheck S D T}
      {System.showInfo S # D # "\t check: " # {ItemCheck T}}
   end

in      
   {ShowItemCheck "stretch tree of depth " StretchDepth {NewTree 0 StretchDepth}}
   LongLivedTree = {NewTree 0 Max0}
   {DepthLoop Min0 Max0}
   {ShowItemCheck "long lived tree of depth " Max0 LongLivedTree}
   {Application.exit 0}   
end
