/* The Great Computer Language Shootout 
   http://shootout.alioth.debian.org/ 

   unoptimised reference implementation
   
   contributed by Isaac Gouy 
*/

using System;

class BinaryTrees
{
   const int minDepth = 4;

   public static void Main(String[] args) 
   {        
      int n = 0;
      if (args.Length > 0) n = Int32.Parse(args[0]);

      int maxDepth = Math.Max(minDepth + 2, n);
      int stretchDepth = maxDepth + 1;

      int check = (TreeNode.bottomUpTree(0,stretchDepth)).itemCheck();
      Console.WriteLine("stretch tree of depth {0}\t check: {1}", stretchDepth, check);

      TreeNode longLivedTree = TreeNode.bottomUpTree(0,maxDepth);

      for (int depth=minDepth; depth<=maxDepth; depth+=2){
         int iterations = 1 << (maxDepth - depth + minDepth);

         check = 0;
         for (int i=1; i<=iterations; i++)
         {
            check += (TreeNode.bottomUpTree(i,depth)).itemCheck();  
            check += (TreeNode.bottomUpTree(-i,depth)).itemCheck(); 
         }

         Console.WriteLine("{0}\t trees of depth {1}\t check: {2}", 
            iterations*2, depth, check);
      }
 
      Console.WriteLine("long lived tree of depth {0}\t check: {1}", 
         maxDepth, longLivedTree.itemCheck());
   }


   class TreeNode 
   {     
      private TreeNode left, right;
      private int item;

      TreeNode(int item){
         this.item = item;
      }

      internal static TreeNode bottomUpTree(int item, int depth){
         if (depth>0){
            return new TreeNode(
                 bottomUpTree(2*item-1, depth-1)
               , bottomUpTree(2*item, depth-1)
               , item
               );
         }
         else {
            return new TreeNode(item);
         }
      }

      TreeNode(TreeNode left, TreeNode right, int item){
         this.left = left; 
         this.right = right;
         this.item = item;
      }

      internal int itemCheck(){
         // if necessary deallocate here 
         if (left==null) return item;
         else return item + left.itemCheck() - right.itemCheck(); 
      }
   }
}