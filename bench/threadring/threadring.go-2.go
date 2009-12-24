/* The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * contributed by The Go Authors.
 * flag.Arg hack and GOMAXPROCS fun by Isaac Gouy
 */

package main

import (
   "flag"
   "fmt"
   "os"
   "strconv"
   "runtime"
)

var n = 0

const Nthread = 503

func f(i int, in <-chan int, out chan<- int) {
   for {
      n := <-in
      if n == 0 {
         fmt.Printf("%d\n", i)
         os.Exit(0)
      }
      out <- n - 1
   }
}

func main() {
   flag.Parse()
   if flag.NArg() > 0 { n,_ = strconv.Atoi( flag.Arg(0) ) }
   runtime.GOMAXPROCS(4)

   one := make(chan int)   // will be input to thread 1
   var in, out chan int = nil, one
   for i := 1; i <= Nthread-1; i++ {
      in, out = out, make(chan int)
      go f(i, in, out)
   }
   go f(Nthread, out, one)
   one <- n
   <-make(chan int)   // hang until ring completes
}
