/* The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * contributed by Martin Koistinen <mkoistinen@gmail.com>
 * Based on mandelbrot.c contributed by Greg Buchholz and The Go Authors
 */

package main

import (
   "bufio";
   "flag";
   "fmt";
   "os";
   "strconv";
)

const ITER = 50
const ZERO float64 = 0
const LIMIT = 2.0

var n, h, w int
var out *bufio.Writer
var control chan bool

// This func is responsible for rendering a row of pixels,
// and when complete writing it out to the file.
func renderRow(y int, myChan chan bool) {

   bytes := int(w / 8);
   if w%8 > 0 {
      bytes++
   }

   // This will hold the pixels
   row := make([]byte, bytes, bytes);

   var by, bi int;

   for x := 0; x < w; x++ {
      Zr, Zi, Tr, Ti := ZERO, ZERO, ZERO, ZERO;
      Cr := (2*float64(x)/float64(w) - 1.5);
      Ci := (2*float64(y)/float64(h) - 1.0);

      for i := 0; i < ITER && (Tr+Ti <= LIMIT*LIMIT); i++ {
         Zi = 2*Zr*Zi + Ci;
         Zr = Tr - Ti + Cr;
         Tr = Zr * Zr;
         Ti = Zi * Zi;
      }

      by = x / 8;
      bi = x % 8;

      // Store the value in the array of ints
      if Tr+Ti <= LIMIT*LIMIT {
         // Create a bit mask for the proper bit
         mask := byte(1) << uint(7-bi);

         // OR the mask into the byte
         row[by] = row[by] | mask;
      }
   }

   // OK, We've computed this row... wait for the signal to write it out...
   <-myChan;

   for i := 0; i < bytes; i++ {
      out.WriteByte(row[i])
   }

   myChan <- true;   // Signal that we're done writing
   return;
}

// All file writing will be controlled from here
// This goroutine signals each row, in order, to write their data,
// Waits for it to complete, then allows the next row to go...
func sequencer(rows [](chan bool)) {

   // First write the 'header' for the pbm file...
   fmt.Fprintf(out, "P4\n%d %d\n", w, h);

   for i:=0; i<h; i++ {
      rows[i] <- true;   // Tell the row it can write when it is ready
      <-rows[i];      // Wait until it signals it is finished
   }

   control <- true;   // Signal that we're done!
   return;
}

func main() {

   flag.Parse();
   if flag.NArg() > 0 {
      n, _ = strconv.Atoi(flag.Arg(0))
   }

   w, h = n, n;

   out = bufio.NewWriter(os.Stdout);
   defer out.Flush();

   control = make(chan bool);

   rows := make([]chan bool, h, h);
   go sequencer(rows);

   // Spawn a new goroutine for each row...
   for row := 0; row < n; row++ {
      rows[row] = make(chan bool);
      go renderRow(row, rows[row]);
   }

   // Wait for all the rows to be written...
   <-control;
}
