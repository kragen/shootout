(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org
   
   Unoptimised reference implementation

   contributed by Isaac Gouy (Oberon-2 novice)   
*)


MODULE binarytrees;
IMPORT Shootout, Out;

CONST
   minDepth = 4;

TYPE
   TreeNode = POINTER TO TreeNodeDesc;
   TreeNodeDesc = RECORD
      left, right: TreeNode;
      item: LONGINT;
   END;

VAR
   n, maxDepth, stretchDepth, depth, iterations, check, i: LONGINT;
   stretchTree, longLivedTree, tempTree: TreeNode;


PROCEDURE NewTreeNode(item: LONGINT): TreeNode;
VAR t: TreeNode;
BEGIN
   NEW(t); t.item := item;
   RETURN t;
END NewTreeNode;


PROCEDURE NewTree(left, right: TreeNode; item: LONGINT): TreeNode;
VAR t: TreeNode;
BEGIN
   NEW(t); t.item := item; t.left := left; t.right := right;
   RETURN t;
END NewTree;


PROCEDURE BottomUpTree(item, depth: LONGINT): TreeNode;
BEGIN
   IF depth > 0 THEN
      RETURN NewTree(
          BottomUpTree(2*item-1,depth-1)
         ,BottomUpTree(2*item,depth-1)
         ,item
      );
   ELSE
      RETURN NewTreeNode(item);
   END;
END BottomUpTree;


PROCEDURE (t:TreeNode) ItemCheck(): LONGINT;
BEGIN
   IF t.left = NIL THEN RETURN t.item;
   ELSE RETURN t.item + t.left.ItemCheck() - t.right.ItemCheck();
   END;
END ItemCheck;


PROCEDURE ShowCheck(i,depth,check: LONGINT);
BEGIN
   Out.Int(i,1); Out.Char(9X); Out.String(" trees of depth ");
   Out.Int(depth,1); Out.Char(9X); Out.String(" check: ");
   Out.Int(check,1);  Out.Ln;
END ShowCheck;


PROCEDURE ShowItemCheck(depth: LONGINT; t: TreeNode; s: ARRAY OF CHAR);
BEGIN
   Out.String(s); Out.Int(depth,1); Out.Char(9X);  Out.String(" check: "); 
   Out.Int(t.ItemCheck(),1);  Out.Ln;
END ShowItemCheck;


BEGIN
   n := Shootout.Argi();

   IF minDepth+2 > n THEN maxDepth := minDepth+2; ELSE maxDepth := n; END;
   stretchDepth := maxDepth + 1;

   stretchTree := BottomUpTree(0,stretchDepth);
   ShowItemCheck(stretchDepth, stretchTree, "stretch tree of depth ");   
   stretchTree := NIL;

   longLivedTree := BottomUpTree(0,maxDepth);

   FOR depth:=minDepth TO maxDepth BY 2 DO
      iterations := ASH(1, maxDepth-depth+minDepth);
      check := 0;
      FOR i:=1 TO iterations DO
         tempTree := BottomUpTree(i,depth);
         INC(check, tempTree.ItemCheck());
         tempTree := NIL;   
         
         tempTree := BottomUpTree(-i,depth);
         INC(check, tempTree.ItemCheck());
         tempTree := NIL;               
      END;
      ShowCheck(iterations*2,depth,check);
   END;

   ShowItemCheck(maxDepth, longLivedTree, "long lived tree of depth ");
END binarytrees.