#!/bin/env groovy
/*
	$Id: binarytrees.groovy,v 1.1 2005-09-18 05:01:24 igouy-guest Exp $

	The Great Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
	modified by 

    Each program should
    
        * define a tree node class and methods, a tree node record and procedures, or an algebraic data type and functions, or?
        * allocate a binary tree to 'stretch' memory, check it exists, and deallocate it
        * allocate a long-lived binary tree which will live-on while other trees are allocated and deallocated
        * allocate, walk, and deallocate many bottom-up binary trees
            o allocate a tree
            o walk the tree nodes, checksum node items (and maybe deallocate the node)
            o deallocate the tree
        * check that the long-lived binary tree still exists
    
    (Note: the left subtrees are heads of the right subtrees, keeping a depth counter in the accessors to avoid duplication is cheating!)
    
    There are reference implementations in OCaml, C#, and PHP.
    
    Correct output N = 10 is:
    
    stretch tree of depth 11         check: -1
    2048     trees of depth 4        check: -2048
    512      trees of depth 6        check: -512
    128      trees of depth 8        check: -128
    32       trees of depth 10       check: -32
    long lived tree of depth 10      check: -1
    
    
    The binary-trees benchmark is a simplistic adaptation of Hans Boehm's GCBench, which in turn was adapted from a benchmark by John Ellis and Pete Kovac.
    
    Thanks to Christophe Troestler and Einar Karttunen for help with this benchmark.

	Iterations can also be computed using 2**(maxDepth - depth + minDepth)
*/
class TreeNode {
      private left, right
      private item

      TreeNode(int item){
         this.item = item
      }

      private static TreeNode bottomUpTree(int item, int depth) {
         if (depth>0) {
            return new TreeNode(
                 bottomUpTree(2*item-1, depth-1)
               , bottomUpTree(2*item, depth-1)
               , item
               )
         } else {
            return new TreeNode(item)
         }
      }

      TreeNode(TreeNode left, TreeNode right, int item){
         this.left = left
         this.right = right
         this.item = item
      }

      private int itemCheck(){
         // if necessary deallocate here
         if (left==null) return item
         else return item + left.itemCheck() - right.itemCheck()
      }
}

def n = (args.length == 0) ? 10 : args[0].toInteger()
def minDepth = 4
def maxDepth = [ minDepth + 2, n].max()
def stretchDepth = maxDepth + 1

def check = (TreeNode.bottomUpTree(0,stretchDepth)).itemCheck()
println "stretch tree of depth ${stretchDepth}\t  check: ${check}"

def longLivedTree = TreeNode.bottomUpTree(0,maxDepth)

def depth=minDepth
while (depth<=maxDepth) {
	def iterations = 1 << (maxDepth - depth + minDepth)

	check = 0
    for (i in 1..iterations) {
		check += (TreeNode.bottomUpTree(i,depth)).itemCheck()
        check += (TreeNode.bottomUpTree(-i,depth)).itemCheck()
    }

    println "${iterations*2}\t  trees of depth ${depth}\t  check: ${check}"
    
	depth+=2
}

println "long lived tree of depth ${maxDepth}\t  check: ${longLivedTree.itemCheck()}"

// EOF
