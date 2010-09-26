/* The Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Kannan Goundan
   modified by Isaac Gouy
   optimized by David Pollak
   updated to 2.8 by Rex Kerr
   modified by Piotr Tarsa
*/

sealed abstract class Node(i: Int, left: Node, right: Node) {
  def isum: Int
}
case class NonLeaf(i: Int, left: Node, right: Node) extends Node(i, left, right) {
  def isum: Int = i + left.isum - right.isum
}
case class Leaf(i: Int) extends Node(i, NullNode, NullNode) {
  def isum: Int = i
}
case object NullNode extends Node(0, new Leaf(0), new Leaf(0)) {
  def isum: Int = 0
}

object Tree {
  def apply(i: Int, depth: Int): Node = {
    if (depth > 0) NonLeaf(i, Tree(i * 2 - 1, depth - 1), Tree(i * 2, depth - 1))
    else Leaf(i)
  }
}

object binarytrees {
  def main(args: Array[String]) = {
    val n = try{ args(0).toInt } catch { case _ => 1 }
    val minDepth = 4
    val maxDepth = n max (minDepth + 2)

    def print(name: String, depth: Int, check: Int) =
      println(name + " of depth " + depth + "\t check: " + check)

    print("stretch tree", maxDepth + 1, Tree(0, maxDepth + 1).isum)
    val longLivedTree = Tree(0, maxDepth)
    minDepth to maxDepth by 2 foreach {
      depth =>
      val iterations = 1 << (maxDepth - depth + minDepth)
      var i, sum = 0
      while (i < iterations) {
        i += 1
        sum += Tree(i, depth).isum + Tree(-i, depth).isum
      }
      print(iterations *2  + "\t trees", depth, sum)
    }
    print("long lived tree", maxDepth, longLivedTree.isum)
  }
}