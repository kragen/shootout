/* The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * contributed by The Go Authors.
 * Based on spectral-norm.c by Sebastien Loisel
 * flag.Arg hack by Isaac Gouy
 */

package main

import (
   "flag"
   "fmt"
   "math"
   "runtime"
   "strconv"
)

var n = 0    // var n = flag.Int("n", 2000, "count")
var nCPU = 4 // var nCPU = flag.Int("ncpu", 4, "number of cpus")

func evalA(i, j int) float64 {
   return 1 / float64(((i + j)*(i + j + 1)/2 + i + 1))
}

type Vec []float64

func (v Vec) Times(i, n int, u Vec, c chan int) {
   for ; i < n; i++ {
      v[i] = 0
      for j := 0; j < len(u); j++ {
         v[i] += evalA(i, j)*u[j]
      }
   }
   c <- 1
}

func (v Vec) TimesTransp(i, n int, u Vec, c chan int) {
   for ; i < n; i++ {
      v[i] = 0
      for j := 0; j < len(u); j++ {
         v[i] += evalA(j, i)*u[j]
      }
   }
   c <- 1
}

func wait(c chan int) {
   for i := 0; i < nCPU; i++ {
      <-c
   }
}

func (v Vec) ATimesTransp(u Vec) {
   x := make(Vec, len(u))
   c := make(chan int, nCPU)
   for i := 0; i < nCPU; i++ {
      go x.Times(i*len(v) / nCPU, (i+1)*len(v) / nCPU, u, c)
   }
   wait(c)
   for i := 0; i < nCPU; i++ {
      go v.TimesTransp(i*len(v) / nCPU, (i+1)*len(v) / nCPU, x, c)
   }
   wait(c)
}

func main() {
   flag.Parse()
   if flag.NArg() > 0 { n,_ = strconv.Atoi( flag.Arg(0) ) }
   runtime.GOMAXPROCS(nCPU)

   N := n
   u := make(Vec, N)
   for i := 0; i < N; i++ {
      u[i] = 1
   }
   v := make(Vec, N)
   for i := 0; i < 10; i++ {
      v.ATimesTransp(u)
      u.ATimesTransp(v)
   }
   var vBv, vv float64
   for i := 0; i < N; i++ {
      vBv += u[i]*v[i]
      vv += v[i]*v[i]
   }
   fmt.Printf("%0.9f\n", math.Sqrt(vBv/vv))
}
