/* The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * Contributed by Martin Koistinen 
 * Based on mandelbrot.c contributed by Greg Buchholz and The Go Authors
 * flag.Arg hack by Isaac Gouy
 *
 * Version 4
 */

package main

import (
   "bufio";
   "flag";
   "fmt";
   "os";
   "strconv";
   "runtime";
   "syscall";
)

const ZERO float64 = 0
const LIMIT = 2.0
const ITER = 50   // Benchmark parameter

// This func is responsible for rendering a row of pixels,
// and when complete writing it out to the file.
func renderRow(w, h, y int, myChan chan bool, out *bufio.Writer) {

   var row []byte;
   var Zr, Zi, Tr, Ti, Cr float64;
   var x, i int;

   bytes := int(w / 8);
   if w%8 > 0 {
      bytes++
   }

   // This will hold the pixels
   row = make([]byte, bytes);

   Ci := (2*float64(y)/float64(h) - 1.0);

   for x = 0; x < w; x++ {
      Zr, Zi, Tr, Ti = ZERO, ZERO, ZERO, ZERO;
      Cr = (2*float64(x)/float64(w) - 1.5);

      for i = 0; i < ITER && Tr+Ti <= LIMIT*LIMIT ; i++ {
         Zi = 2*Zr*Zi + Ci;
         Zr = Tr - Ti + Cr;
         Tr = Zr * Zr;
         Ti = Zi * Zi;
      }

      // Store the value in the array of ints
      if Tr+Ti <= LIMIT * LIMIT {
         row[x/8] |= (byte(1) << uint(7-(x%8)));
      }
   }

   // OK, We've computed this row... wait for the signal to write it out...
   <-myChan;

   for i = 0; i < bytes; i++ {
      out.WriteByte(row[i])
   }

   myChan <- true;   // Signal that we're done writing
   return;
}

func main() {
   runtime.GOMAXPROCS(8);   // This is the max. number of processors to use

   size := 16000; // Contest settings

   // Get input, if any...
   flag.Parse();
   if flag.NArg() > 0 {
      size, _ = strconv.Atoi(flag.Arg(0));
   }
   w, h := size, size;

   out := bufio.NewWriter(os.Stdout);
   defer out.Flush();

   rows := make([]chan bool, h, h);

   // First write the 'header' for the pbm file...
   fmt.Fprintf(out, "P4\n%d %d\n", w, h);

   // Spawn a new goroutine for each row...
   for row := 0; row < h; row++ {
      syscall.Sleep(1e3);   // Wait a tiny bit to avoid a malloc bug in the runtime
      rows[row] = make(chan bool);
      go renderRow(w, h, row, rows[row], out);
   }

   // Secquence the results to the file
   for i:=0; i<h; i++ {
      rows[i] <- true;   // Tell the row it can write when it is ready
      <-rows[i];      // Wait until it signals it is finished
   }
}
