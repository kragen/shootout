/* The Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Kannan Goundan
   modified by Isaac Gouy
   optimized by David Pollak
   updated for 2.8 and parallelized by Rex Kerr
*/

import scala.actors.Futures._

object binarytrees {
  def report(name: String, depth: Int, check: Int) =
    println(name + " of depth " + depth + "\t check: " + check)

  def main(args: Array[String]) = {
    val n = try{ args(0).toInt } catch { case _ => 1 }
    val minDepth = 4
    val maxDepth = n max (minDepth+2)
    val threads = 3  // More than 3 tends to overwhelm GC

    report("stretch tree", maxDepth+1, Tree(0,maxDepth+1).isum)
    val longLivedTree = Tree(0,maxDepth)
    var depth = minDepth
    while (depth <= maxDepth) {
      val iterations = 1 << (maxDepth - depth + minDepth)
      val limits = (0 to threads).map(_*iterations/threads).sliding(2).toList
      val check = limits.map(i => future(Go(i(0)+1,i(1),depth).calc))
      report(iterations*2 + "\t trees", depth, check.map(_()).sum)
      depth += 2
    }
    report("long lived tree", maxDepth, longLivedTree.isum)
  }
}

case class Sum(var sum: Int) {
  def +=(i: Int) = { sum+=i; this }
}

case class Go(i0: Int, i1: Int, depth: Int) {
  def calc = (Sum(0) /: (i0 to i1))((s,i) =>
    s += Tree(i,depth).isum + Tree(-i,depth).isum
  ).sum
}

final class Tree(i: Int, left: Tree, right: Tree) {
  def isum: Int = if (left eq null) i else i + left.isum - right.isum
}
object Tree {
  def apply(i: Int, depth: Int): Tree = {
    if (depth > 0) new Tree(i, Tree(i*2-1, depth-1), Tree(i*2, depth-1))
    else new Tree(i, null, null)
  }
}

