/* The Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Kannan Goundan
   modified by Isaac Gouy
   optimized by David Pollak
*/

object binarytrees {
   def main(args: Array[String]) = {
      val n = try { Integer.parseInt(args(0)) } catch { case _ => 1 }
      val minDepth = 4
      val maxDepth = Math.max(minDepth+2,n)

      print("stretch tree", maxDepth+1, Tree(0,maxDepth+1).isum)

      val longLivedTree = Tree(0,maxDepth)

      var depth = minDepth
      while (depth <= maxDepth) {
         val iterations = 1 << (maxDepth - depth + minDepth)

         var sum = 0
         var i = 1
         while (i <= iterations) {
            sum = sum + Tree(i,depth).isum + Tree(-i,depth).isum
            i = i + 1
         }
         print(iterations*2 + "\t trees", depth, sum)

         depth = depth + 2
      }

      print("long lived tree", maxDepth, longLivedTree.isum)
   }

   def print(name: String, depth: Int, check: Int) =
      Console.println(name + " of depth " + depth + "\t check: " + check)
}

object Tree {
  def apply(i: int, depth: int): Tree = {
    if (depth > 0) {val d1 = depth - 1; val i2 = i * 2; new Tree(i, Tree(i2-1, d1), Tree(i2, d1))}
    else new Tree(i, null, null)
  }
}

final class Tree(val i: int,val left: Tree, val right: Tree) { //  depth: int) {
    def isum: int = {
       val tl = left
       if (tl eq null) i
       else i + tl.isum - right.isum
    }
}

