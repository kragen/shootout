/* The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * contributed by The Go Authors.
 */

package main

import (
   "bufio";
   "bytes";
   "os";
)

const   lineSize = 60

var complement = [256]uint8 {
   'A':   'T',   'a':   'T',
   'C':   'G',   'c':   'G',
   'G':   'C',   'g':   'C',
   'T':   'A',   't':   'A',
   'U':   'A',   'u':   'A',
   'M':   'K',   'm':   'K',
   'R':   'Y',   'r':   'Y',
   'W':   'W',   'w':   'W',
   'S':   'S',   's':   'S',
   'Y':   'R',   'y':   'R',
   'K':   'M',   'k':   'M',
   'V':   'B',   'v':   'B',
   'H':   'D',   'h':   'D',
   'D':   'H',   'd':   'H',
   'B':   'V',   'b':   'V',
   'N':   'N',   'n':   'N',
}

var in *bufio.Reader

func reverseComplement(in []byte) []byte {
   outLen := len(in) + (len(in) + lineSize -1)/lineSize;
   out := make([]byte, outLen);
   j := 0;
   k := 0;
   for i := len(in)-1; i >= 0; i-- {
      if k == lineSize {
         out[j] = '\n';
         j++;
         k = 0;
      }
      out[j] = complement[in[i]];
      j++;
      k++;
   }
   out[j] = '\n';
   j++;
   return out[0:j];
}

func output(buf []byte) {
   if len(buf) == 0 {
      return
   }
   os.Stdout.Write(reverseComplement(buf));
}

func main() {
   in = bufio.NewReader(os.Stdin);
   buf := make([]byte, 100*1024);
   top := 0;
   for {
      line, err := in.ReadSlice('\n');
      if err != nil {
         break
      }
      if line[0] == '>' {
         if top > 0 {
            output(buf[0:top]);
            top = 0;
         }
         os.Stdout.Write(line);
         continue
      }
      line = line[0:len(line)-1];   // drop newline
      if top+len(line) > len(buf) {
         nbuf := make([]byte, 2*len(buf) + 1024*(100+len(line)));
         bytes.Copy(nbuf, buf[0:top]);
         buf = nbuf;
      }
      bytes.Copy(buf[top:len(buf)], line);
      top += len(line);
   }
   output(buf[0:top]);
}
