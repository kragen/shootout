/* The Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Kannan Goundan
   modified by Isaac Gouy
   optimized by David Pollak
   updated to 2.8 by Rex Kerr
*/

object binarytrees {
  def main(args: Array[String]) = {
    val n = try{ args(0).toInt } catch { case _ => 1 }
    val minDepth = 4
    val maxDepth = n max (minDepth+2)

    def print(name: String, depth: Int, check: Int) =
      println(name + " of depth " + depth + "\t check: " + check)

    print("stretch tree", maxDepth+1, Tree(0,maxDepth+1).isum)
    val longLivedTree = Tree(0,maxDepth)
    var depth = minDepth
    while (depth <= maxDepth) {
      val iterations = 1 << (maxDepth - depth + minDepth)
      var i,sum = 0
      while (i < iterations) {
        i += 1
        sum += Tree(i,depth).isum + Tree(-i,depth).isum
      }
      print(iterations*2 + "\t trees", depth, sum)
      depth += 2
    }
    print("long lived tree", maxDepth, longLivedTree.isum)
  }
}

final class Tree(i: Int, left: Tree, right: Tree) {
  def isum: Int = {
    val tl = left
    if (tl eq null) i
    else i + tl.isum - right.isum
  }
}
object Tree {
  def apply(i: Int, depth: Int): Tree = {
    if (depth > 0) new Tree(i, Tree(i*2-1, depth-1), Tree(i*2, depth-1))
    else new Tree(i, null, null)
  }
}
