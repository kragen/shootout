/* The Great Computer Language Shootout
 *  http://shootout.alioth.debian.org/
 * 
 * @author Simon Brooke <simon@jasmine.org.uk>
 */


/**
 * A class which implments the binary-trees algorithm for the Great
 * Computer Language Shootout. This implementation based fairly
 * straightforwardly on Isaac Gouy's C# reference implementation. That
 * is to say I haven't analysed the algorithm and come up with my own
 * program design; where this implementation differs from Isaac's it
 * is simply that this was easier to make work at the time. This
 * implementation is not at all optimised - I welcome improvements
 */
class binarytrees
{
   static final int MINDEPTH = 4;

   public static void main(String[] args)
   {
      int n = 0;

      if (args.length > 0) n = Integer.parseInt(args[0]);

      new binarytrees( n);
   }


    /** 
     * Java is fussy about non-static stuff being accessed from static 
     * stuff, so the simplest solution was to create an object and do
     * everything in that object. There isn't much to do so it's all
     * done in the Constructor
     */
    public binarytrees( int maxDepth)
    {
	int dflt = MINDEPTH + 2;

	if ( dflt > maxDepth) maxDepth = dflt;

	int stretchDepth = maxDepth + 1;

	int check = ( new TreeNode(0,stretchDepth)).itemCheck();

	/* allegedly, concatenating String objects in Java is inefficient;
	 * the StringBuffer is used here in a naive attempt to improve
	 * preformance. I haven't verified that it does so */
	StringBuffer buff = new StringBuffer( "stretch tree of depth ");
	buff.append( stretchDepth).append( "\t check: ").append( check);
	System.out.println( buff.toString());

	TreeNode longLivedTree = new TreeNode(0,maxDepth);

	for (int depth=MINDEPTH; depth<=maxDepth; depth+=2)
	    {
		int iterations = 1 << (maxDepth - depth + MINDEPTH);

		check = 0;
		for (int i=1; i<=iterations; i++)
		    {
			check += ( new TreeNode(i,depth)).itemCheck();
			check += ( new TreeNode(-i,depth)).itemCheck();
		    }

		buff = new StringBuffer( iterations*2);
		buff.append( "\t trees of depth ").append(depth).append( "\t check: ").append( check);
		System.out.println( buff.toString());
	    }
	
	buff = new StringBuffer( "long lived tree of depth ");
	buff.append( maxDepth).append( "\t check: ").append( longLivedTree.itemCheck());
	System.out.println( buff.toString());
    }

    /* a node in a binary tree */
    class TreeNode
    {
	private TreeNode left = null, right = null;
	private int item;


	/**
	 * construct me with this item; and construct a tree below me of
	 * depth depth, with items suitably offset from this item
	 *
	 * @param item my item value
	 * @param depth the depth of the tree to create beneath me.
	 */
	TreeNode( int item, int depth)
	{
	    if ( depth > 0)
		{
		    left = new TreeNode( 2*item-1, depth-1);
		    right = new TreeNode( 2*item, depth-1);
		}
	    this.item = item;
	}


	protected int itemCheck()
	{
	    // if necessary deallocate here
	    if (left==null) return item;
	    else return item + left.itemCheck() - right.itemCheck();
	}
    }
}