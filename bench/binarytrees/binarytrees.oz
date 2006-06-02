% ----------------------------------------------------------------------
% The Great Computer Language Shootout                              
% http://shootout.alioth.debian.org/                                
%                                                                   
% Contributed by Anthony Borla
% ----------------------------------------------------------------------

functor

import
  System(showInfo show) Application(exit getArgs)

define

% ------------- %

  fun {MakeTree Item Left Right}
    tree(item:Item left:Left right:Right)
  end

% ------------- %

  fun {BottomUpTree Item Depth}
    if Depth > 0 then
      {MakeTree Item
        {BottomUpTree (2 * Item - 1) (Depth - 1)}
        {BottomUpTree (2 * Item) (Depth - 1)}}
    else
      {MakeTree Item nil nil}
    end
  end

% ------------- %

  fun {CheckTree Tree}
    if Tree.left == nil then
      Tree.item
    else
      Tree.item + {CheckTree Tree.left} - {CheckTree Tree.right}
    end
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

  MIN_DEPTH = 4  MAX_DEPTH  STRETCH_DEPTH  LONG_LIVED_TREE  N

  ITERATIONS = {NewCell 0}  CHECK = {NewCell 0}

% ------------- %

in
  N = {CmdlNArg 1 10}

  MAX_DEPTH = if MIN_DEPTH + 2 > N then MIN_DEPTH + 2 else N end
  STRETCH_DEPTH = MAX_DEPTH + 1

  {System.showInfo
    "stretch tree of depth " # STRETCH_DEPTH #
    "\t check: " # {CheckTree {BottomUpTree 0 STRETCH_DEPTH}}}

  LONG_LIVED_TREE = {BottomUpTree 0 MAX_DEPTH}

  for Depth in MIN_DEPTH;(Depth =< MAX_DEPTH);(Depth + 2) do
    ITERATIONS := {Number.pow 2 (MAX_DEPTH - Depth + MIN_DEPTH)} 

    CHECK := 0
    for I in 1;(I =< @ITERATIONS);(I + 1) do
      CHECK := @CHECK + {CheckTree {BottomUpTree I Depth}}
      CHECK := @CHECK + {CheckTree {BottomUpTree ~I Depth}}
    end

    {System.showInfo 
      (@ITERATIONS * 2) #
      "\t trees of depth " # Depth #
      "\t check: " # @CHECK}
  end

  {System.showInfo
    "long lived tree of depth " # MAX_DEPTH #
    "\t check: " # {CheckTree LONG_LIVED_TREE}}

  {Application.exit 0}
end

