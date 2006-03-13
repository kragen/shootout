/* The Computer Language Shootout
 * http://shootout.alioth.debian.org/
 * contributed by  Robert Brandner
 * based on the Java version by Jarkko Miettinen
 */

int main(int argc, array(string) argv) {

	int minDepth = 4;

	int n = argc > 1 ? (int)argv[1] : 10;

	int maxDepth = (minDepth + 2 > n) ? minDepth + 2 : n;
	int stretchDepth = maxDepth + 1;
	
	write("stretch tree of depth " + stretchDepth + "\t check: " + itemCheck(bottomUpTree(0,stretchDepth)) + "\n");
	
	TreeNode longLivedTree = bottomUpTree(0,maxDepth);

	for (int depth=minDepth; depth<=maxDepth; depth+=2){
		int iterations = 1 << (maxDepth - depth + minDepth);
		int check = 0;
		for (int i=1; i<=iterations; i++){
			check += itemCheck(bottomUpTree(i,depth));
			check += itemCheck(bottomUpTree(-i,depth));
		}
		write((iterations*2) + "\t trees of depth " + depth + "\t check: " + check+"\n");
	}
	write("long lived tree of depth " + maxDepth + "\t check: "+ itemCheck(longLivedTree)+"\n");
}

TreeNode bottomUpTree(int item, int depth) {
	if (depth>0) {
		return TreeNode(item, bottomUpTree(2*item-1, depth-1), bottomUpTree(2*item, depth-1));
	}
	else {
		return TreeNode(item);
	}
}

int itemCheck(TreeNode t) {
	if (t->left==0) {return t->item;}
	else {return t->item + itemCheck(t->left) - itemCheck(t->right);}
}

class TreeNode {
	TreeNode left, right;
	int item;
	
	void create(int it, TreeNode|void l, TreeNode|void r) {
		item = it;
		left = l;
		right = r;
	}
}