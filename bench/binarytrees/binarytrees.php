<? /* The Great Computer Language Shootout 
   http://shootout.alioth.debian.org/
   
   contributed by Isaac Gouy (PHP novice)
   
   php -q binarytrees.php 12
*/


class TreeNode {
   var $_left, $_right, $_item; 
   
   function TreeNode($item){ $this->_item = (integer)$item; }
                                               
   function newTree(&$left, &$right, $item){ 
      $t = new TreeNode($item);
      $t->_left = $left; 
      $t->_right = $right;    
      return $t;
   }         
      
   function bottomUpTree($item,$depth){ 
      if ($depth>0){
         return TreeNode::newTree(
             TreeNode::bottomUpTree(2*$item-1,$depth-1)
            ,TreeNode::bottomUpTree(2*$item,$depth-1)
            ,$item
            );
         }
      else {
         return new TreeNode($item);
      }
   }       
   
   function itemCheck(){ 
      if (!isset($this->_left)){ return $this->_item; }
      else {return 
         $this->_item + 
            $this->_left->itemCheck() - $this->_right->itemCheck(); 
      }
   }                             
}



$minDepth = 4;

$n = ($argc == 2) ? $argv[1] : 1;
$maxDepth = max($minDepth + 2, $n);
$stretchDepth = $maxDepth + 1;

$stretchTree = TreeNode::bottomUpTree(0,$stretchDepth);
printf("stretch tree of depth %d\t check: %d\n", 
   $stretchDepth, $stretchTree->itemCheck());
unset($stretchTree);

$longLivedTree = TreeNode::bottomUpTree(0,$maxDepth);

for ($depth=$minDepth; $depth<=$maxDepth; $depth+=2){
   $iterations = 1 << ($maxDepth - $depth + $minDepth);

   $check = 0;
   for ($i=1; $i<=$iterations; $i++){
      $t = TreeNode::bottomUpTree($i,$depth);
      $check += $t->itemCheck();
      unset($t);       
      
      $t = TreeNode::bottomUpTree(-$i,$depth);
      $check += $t->itemCheck();
      unset($t);            
   }
   
   printf("%d\t trees of depth %d\t check: %d\n",
      2*$iterations, $depth, $check);
}

printf("long lived tree of depth %d\t check: %d\n", 
   $maxDepth, $longLivedTree->itemCheck());

?>