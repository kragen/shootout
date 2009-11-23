/* The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * Contributed by Martin Koistinen <mkoistinen@gmail.com>
 * Based on mandelbrot.c contributed by Greg Buchholz and The Go Authors
 * flag.Arg hack by Isaac Gouy
 *
 * Version 5
 */

package main

import (
   "bufio";
   "flag";
   "fmt";
   "os";
   "strconv";
   "runtime";
)

const ZERO float64 = 0
const LIMIT = 2.0
const SIZE = 16000
const ITER = 50
const ROWSPERGOROUTINE = 100
const MAXPROCS = 4

var data []byte
var bytesPerRow int

// This func is responsible for rendering a slice of pixels,
// and storing them in the data array.
func renderRow(w, h, ys, iter int, mChan chan bool) {

   var Zr, Zi, Tr, Ti, Cr float64;
   var i, x int;

   for y := ys; y < ys + ROWSPERGOROUTINE && y < h; y++ {

      offset := bytesPerRow * y;
      Ci := (2*float64(y)/float64(h) - 1.0);

      for x = 0; x < w; x++ {
         Zr, Zi, Tr, Ti = ZERO, ZERO, ZERO, ZERO;
         Cr = (2*float64(x)/float64(w) - 1.5);

         for i = 0; i < iter && Tr+Ti <= LIMIT*LIMIT; i++ {
            Zi = 2*Zr*Zi + Ci;
            Zr = Tr - Ti + Cr;
            Tr = Zr * Zr;
            Ti = Zi * Zi;
         }

         // Store the value in the data array
         if Tr+Ti <= LIMIT*LIMIT {
            data[offset+x/8] |= (byte(1) << byte(7-(x%8)))
         }
      }

   }

   mChan <- true;
   return;
}

func main() {
   runtime.GOMAXPROCS(MAXPROCS);   // This is the max. number of processors to use

   size := SIZE;   // Contest settings
   iter := ITER;   // Contest settings

   // Get input, if any...
   flag.Parse();
   if flag.NArg() > 0 {
      size, _ = strconv.Atoi(flag.Arg(0))
   }

   w, h := size, size;

   // The number of bytes to allocate for each row
   bytesPerRow = w / 8;

   out := bufio.NewWriter(os.Stdout);
   defer out.Flush();

   // Allocate space for the data bytes
   data = make([]byte, bytesPerRow*h);

   // Create a comms channel...
   comm := make(chan bool);

   count := 0;

   // Spawn a new goroutine for each row...
   for y := 0; y < h; y += ROWSPERGOROUTINE {
      go renderRow(w, h, y, iter, comm);
      count++;
   }

   // Wait for all the rows to complete...
   for i := 0; i < count; i++ {
      <-comm
   }

   // Write the 'header' for the pbm file...
   fmt.Fprintf(out, "P4\n%d %d\n", w, h);

   out.Write(data);
}
