/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
 
   contributed by Jarkko Miettinen
   modified by Leonhard Holz
*/

public class binarytrees {

   private final static int minDepth = 4;
   private final static int threadCount = 4;
   private final static TreeGenerator[] threads = new TreeGenerator[threadCount];
   
   public static void main(String[] args)
   {
      int n = 0;
      if (args.length > 0) n = Integer.parseInt(args[0]);
      
      int maxDepth = (minDepth + 2 > n) ? minDepth + 2 : n;
      
      TreeGenerator stretcher = new TreeGenerator(0, 0, maxDepth + 1);
      try {
         stretcher.start();
         stretcher.join();
      } catch (InterruptedException e) {
         e.printStackTrace();
      }
      int check = stretcher.getCheckResult();
      System.out.println("stretch tree of depth " + (maxDepth + 1) + "\t check: " + check);

      TreeGenerator longLived = new TreeGenerator(0, 0, maxDepth);
      try {
         longLived.start();
         longLived.join();
      } catch (InterruptedException e) {
         e.printStackTrace();
      }
      
      for (int depth = minDepth; depth <= maxDepth; depth+=2 ) {

         check = 0;
         int iterations = 1 << (maxDepth - depth + minDepth);
         int length = iterations / threadCount;

         for (int i = 0; i < threadCount; i++) {
            threads[i] = new TreeGenerator(i * length, (i + 1) * length, depth);
            threads[i].start();
         }
         for (int i = 0; i < threadCount; i++) try {
            threads[i].join();
            check += threads[i].getCheckResult();
         } catch (InterruptedException e) {
            e.printStackTrace();
         }

         System.out.println((iterations * 2) + "\t trees of depth " + depth + "\t check: " + check);
      }   

      System.out.println("long lived tree of depth " + maxDepth + "\t check: "+ longLived.getCheckResult());
   }

   private static class TreeGenerator extends Thread
   {
      private int start;
      private int end;
      private int depth;
      private int result = 0;
      
      private TreeGenerator(int start, int end, int depth)
      {
         this.end = end;
         this.start = start;
         this.depth = depth;
      }
      
      private int getCheckResult()
      {
         return result;
      }
      
      private TreeNode bottomUpTree(int item, int depth)
      {
         TreeNode node = new TreeNode();
         node.item = item;
         if (depth > 0) {
            node.left = bottomUpTree(2 * item - 1, depth - 1);
            node.right = bottomUpTree(2 * item, depth - 1);
         } else {
            node.left = null;
         }
         return node;
      }

      public void run()
      {
         if (start == end) {
            result += bottomUpTree(start, depth).itemCheck();
         } else for (int i = start; i < end; i++) {
            result += bottomUpTree(i, depth).itemCheck() + bottomUpTree(-i, depth).itemCheck();
         }
      }
   }
   
   private static class TreeNode
   {
      private int item;
      private TreeNode left, right;
      
      private int itemCheck()
      {
         if (left == null) {
            return item;
         } else {
            return item + left.itemCheck() - right.itemCheck();
         }
      }
   }
}
