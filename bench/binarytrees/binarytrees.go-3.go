/* The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * contributed by The Go Authors.
 * based on C program by Kevin Carson
 * flag.Arg hack by Isaac Gouy
 * custom pool and parallel loops by JONNALAGADDA Srinivas
 */

package main

import (
   "flag"
   "fmt"
   "runtime"
   "strconv"
)

type NodeStore struct {
   brk   int
   idx   int
   store []Node
}

func (s *NodeStore) Init(depth int) {
   s.brk = 1 << uint(depth+1)
   s.idx = -1
   s.store = make([]Node, s.brk)
}

func (s *NodeStore) ReInit() {
   s.idx = -1
}

func (s *NodeStore) Alloc(i int, l, r *Node) *Node {
   s.idx++
   p := &(s.store[s.idx])
   (*p).item = i
   (*p).left = l
   (*p).right = r
   return p
}

var n = 0

type Node struct {
   item        int
   left, right *Node
}

func bottomUpTree(item, depth int, store *NodeStore) *Node {
   if depth <= 0 {
      return store.Alloc(item, nil, nil)
   }
   return store.Alloc(item,
      bottomUpTree(2*item-1, depth-1, store),
      bottomUpTree(2*item, depth-1, store))
}

func (n *Node) itemCheck() int {
   if n.left == nil {
      return n.item
   }
   return n.item + n.left.itemCheck() - n.right.itemCheck()
}

const minDepth = 4
const MAXPROCS = 4

func main() {
   flag.Parse()
   if flag.NArg() > 0 {
      n, _ = strconv.Atoi(flag.Arg(0))
   }

   runtime.GOMAXPROCS(MAXPROCS)

   maxDepth := n
   if minDepth+2 > n {
      maxDepth = minDepth + 2
   }
   stretchDepth := maxDepth + 1

   store := new(NodeStore)
   store.Init(stretchDepth)
   check := bottomUpTree(0, stretchDepth, store).itemCheck()
   fmt.Printf("stretch tree of depth %d\t check: %d\n", stretchDepth, check)

   longLivedStore := new(NodeStore)
   longLivedStore.Init(maxDepth)
   longLivedTree := bottomUpTree(0, maxDepth, longLivedStore)

   ss := make([]string, maxDepth+1)
   fn := func(min, max int, ch chan int) {
      for depth := min; depth <= max; depth += (2 * MAXPROCS) {
         iterations := 1 << uint(maxDepth-depth+minDepth)
         check := 0

         store := new(NodeStore)
         store.Init(depth)
         for i := 1; i <= iterations; i++ {
            store.ReInit()
            check += bottomUpTree(i, depth, store).itemCheck()
            store.ReInit()
            check += bottomUpTree(-i, depth, store).itemCheck()
         }
         ss[depth] = fmt.Sprintf("%d\t trees of depth %d\t check: %d\n",
            iterations*2, depth, check)
      }
      ch <- 0
   }

   ch := make(chan int, MAXPROCS)
   for i := 0; i < MAXPROCS; i++ {
      go fn(minDepth+(i*2), maxDepth, ch)
   }
   for i := 0; i < MAXPROCS; i++ {
      <-ch
   }
   for i := minDepth; i <= maxDepth; i += 2 {
      fmt.Print(ss[i])
   }

   fmt.Printf("long lived tree of depth %d\t check: %d\n",
      maxDepth, longLivedTree.itemCheck())
}
