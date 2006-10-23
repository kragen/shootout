/*
  The Computer Language Shootout
  http://shootout.alioth.debian.org/

  - tree: single record type (using null to denote empty)
  - loop: explicit "while"

  Contributed by Kannan Goundan
  De-optimized by Isaac Gouy
*/

object binarytrees {

  class Tree(_i: Int, _left: Tree, _right: Tree) {
    val i: Int = _i
    val left: Tree = _left
    val right: Tree = _right
  }

  def check(tree: Tree): Int = {
    if (tree == null) 0
    else tree.i + check(tree.left) - check(tree.right)
  }

  def make(i: Int, depth: Int): Tree = {
/*  if (depth == 0) null */
    if (depth == 0) new Tree(i, null, null)
    else new Tree(i, make((2*i)-1, depth-1), make(2*i, depth-1))
  }

  def main(args: Array[String]) = {
    val n = try { Integer.parseInt(args(0)) } catch { case _ => 1 }
    val minDepth = 4
    val maxDepth = Math.max(minDepth+2, n)

    print("stretch tree", maxDepth+1, check(make(0, maxDepth+1)))

    val longLived = make(0, maxDepth)

    var depth = minDepth
    while (depth <= maxDepth) {
      val iterations = 1 << (maxDepth - depth + minDepth)

      var sum = 0
      var i = 1
      while (i <= iterations) {
        sum = sum + check(make(i, depth)) + check(make(-i, depth))
        i = i + 1
      }

      print(iterations*2 + "\t trees", depth, sum)

      depth = depth + 2
    }

    print("long lived tree", maxDepth, check(longLived))
  }

  def print(name: String, depth: Int, check: Int) =
    Console.println(name + " of depth " + depth + "\t check: " + check)
}
