/* The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * contributed by Jarkko Miettinen
 * parallelize by The Anh Tran
 */

public class binarytrees
{
    private final static int minDepth = 4;
    
    public static void main (String[] args)
    {
        int n = 18;
        if (args.length > 0)
            n = Integer.parseInt (args[0]);
        
        int maxDepth = (minDepth + 2 > n) ? minDepth + 2 : n;
        int stretchDepth = maxDepth + 1;
        
        // alloc stretchdepth tree, then dealloc
        {
            int check = (TreeNode.bottomUpTree (0, stretchDepth)).itemCheck ();
            System.out.println ("stretch tree of depth " + stretchDepth + "\t check: " + check);
        }
        
        // build longlivedtree
        TreeNode longLivedTree = TreeNode.bottomUpTree (0, maxDepth);
        
        // build many small tree
        AllocWorker.allocTree (minDepth, maxDepth);
        
        System.out.println ("long lived tree of depth " + maxDepth + "\t check: "+ longLivedTree.itemCheck ());
    }
    
    
    private final static class AllocWorker extends Thread
    {
        private static int minDepth;
        private static int maxDepth;
        
        private static int currentdepth;
        private int depth;
        
        private static String[] output;
        
        public static void allocTree (int minD, int maxD)
        {
            minDepth = minD;
            maxDepth = maxD;
            currentdepth = minDepth;
            
            output = new String[maxDepth +1];
            
            Thread rt[] = new Thread[Runtime.getRuntime ().availableProcessors ()];
            for (int i = 0; i < rt.length; i++)
            {
                rt[i] = new AllocWorker ();
                rt[i].start ();
            }
            
            try
            {
                for (int i = 0; i < rt.length; i++)
                    rt[i].join ();
            }
            catch (Exception e)
            {
                e.printStackTrace ();
            }
            
            for (int d = minDepth; d <= maxDepth; d += 2)
                System.out.println (output[d]);
        }
        
        public synchronized void run ()
        {
            while (currentdepth <= maxDepth)
            {
                depth = currentdepth;
                currentdepth += 2;
                
                allocAndCheck ();
            }
        }
        
        private void allocAndCheck ()
        {
            int iterations = 1 << (maxDepth - depth + minDepth);
            int check = 0;
            
            for (int i = 1; i <= iterations; i++)
            {
                check += (TreeNode.bottomUpTree (i,depth)).itemCheck ();
                check += (TreeNode.bottomUpTree (-i,depth)).itemCheck ();
            }
            
            output[depth] = new String ( (iterations * 2) + "\t trees of depth " + depth + "\t check: " + check);
        }
    }
    
    private final static class TreeNode
    {
        private TreeNode left, right;
        private int item;
        
        public TreeNode (int item)
        {
            this.item = item;
        }
        
        public TreeNode (TreeNode left, TreeNode right, int item)
        {
            this.left = left;
            this.right = right;
            this.item = item;
        }
        
        public static TreeNode bottomUpTree (int item, int depth)
        {
            if (depth > 0)
                return new TreeNode (   bottomUpTree (2*item-1, depth-1),
                        bottomUpTree (2*item, depth-1),
                        item    );
            return new TreeNode (item);
        }
        
        public int itemCheck ()
        {
            // if necessary deallocate here
            if (left != null)
                return item + left.itemCheck () - right.itemCheck ();
            return item;
        }
    }
}
