<? /* The Great Computer Language Shootout 
   http://shootout.alioth.debian.org/
   
   contributed by Isaac Gouy 
   
   php -q binarytrees.php 12
*/


class TreeNode {
   var $_left, $_right, $_item; 
   
   function TreeNode($item){ $this->_item = (integer)$item; }
   
   function topDownTree($item,$depth){ 
      $t = new TreeNode($item);   
      return $t->to($depth);
   }   
            
   function to($depth){ 
      if ($depth>0){
         $depth--;
         $t = new TreeNode($this->_item);
         $this->_left = $t->to($depth);
         $t = new TreeNode($this->_item);         
         $this->_right = $t->to($depth);
         }
      return $this;
   }                
                    
   function newTree($left, $right, $item){ 
      $t = new TreeNode($item);
      $t->_left = $left; 
      $t->_right = $right;    
      return $t;
   }         
      
   function bottomUpTree($item,$depth){ 
      if ($depth>0){
         return TreeNode::newTree(
             TreeNode::bottomUpTree($item,$depth-1)
            ,TreeNode::bottomUpTree($item,$depth-1)
            ,$item
            );
         }
      else {
         return new TreeNode($item);
      }
   }       
   
   function nodeItem(){ 
      if (!isset($this->_left)){ return $this->_item; }
      else {return 
         $this->_item + 
            ($this->_left->nodeItem() - $this->_right->nodeItem()); 
      }
   }                
}



$minDepth = 4;
$checkFactor = 64; // keep check in int range

$n = ($argc == 2) ? $argv[1] : 1;
$maxDepth = max($minDepth + 2, $n);
$stretchDepth = $maxDepth + 1;

$stretchTree = TreeNode::topDownTree(0,$stretchDepth);
if (isset($stretchTree)) unset($stretchTree);

$longLivedTree = TreeNode::topDownTree(-1,$maxDepth);

for ($depth=$minDepth; $depth<=$maxDepth; $depth+=2){
   $iterations = 1 << ($maxDepth - $depth + $minDepth);

   $check = (integer)0;
   for ($i=1; $i<=$iterations; $i++){
      $t = TreeNode::topDownTree($i,$depth);
      $check += (integer)($t->nodeItem()/$checkFactor);
      unset($t);
      
      $t = TreeNode::bottomUpTree($i,$depth);      
      $check += (integer)($t->nodeItem()/$checkFactor);  
      unset($t);        
   }
   
   printf("%d\t trees of depth %d\t check: %d\n",
      $iterations*2, $depth, $check);
}

if (isset($longLivedTree) && !isset($stretchTree)){ 
   printf("OK\n");
}

?>