/* The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * contributed by The Go Authors.
 * Based on C program by by Petr Prokhorenkov.
 * flag.Arg hack by Isaac Gouy
 */

package main

import (
   "flag"
   "os"
   "strconv"
)

var out = make(buffer, 0, 32768)

// var n = flag.Int("n", 1000, "length of result")
var n = 0

const Line = 60

func Repeat(alu []byte, n int) {
   buf := append(alu, alu...)
   off := 0
   for n > 0 {
      m := n
      if m > Line {
         m = Line
      }
      buf1 := out.NextWrite(m + 1)
      copy(buf1, buf[off:])
      buf1[m] = '\n'
      if off += m; off >= len(alu) {
         off -= len(alu)
      }
      n -= m
   }
}

const (
   IM = 139968
   IA = 3877
   IC = 29573

   LookupSize  = 4096
   LookupScale float64 = LookupSize - 1
)

var rand uint32 = 42

type Acid struct {
   sym   byte
   prob  float64
   cprob float64
   next  *Acid
}

func computeLookup(acid []Acid) *[LookupSize]*Acid {
   var lookup [LookupSize]*Acid
   var p float64
   for i := range acid {
      p += acid[i].prob
      acid[i].cprob = p * LookupScale
      if i > 0 {
         acid[i-1].next = &acid[i]
      }
   }
   acid[len(acid)-1].cprob = 1.0 * LookupScale

   j := 0
   for i := range lookup {
      for acid[j].cprob < float64(i) {
         j++
      }
      lookup[i] = &acid[j]
   }

   return &lookup
}

func Random(acid []Acid, n int) {
   lookup := computeLookup(acid)
   for n > 0 {
      m := n
      if m > Line {
         m = Line
      }
      buf := out.NextWrite(m + 1)
      f := LookupScale / IM
      myrand := rand
      for i := 0; i < m; i++ {
         myrand = (myrand*IA + IC) % IM
         r := float64(int(myrand)) * f
         a := lookup[int(r)]
         for a.cprob < r {
            a = a.next
         }
         buf[i] = a.sym
      }
      rand = myrand
      buf[m] = '\n'
      n -= m
   }
}

func main() {
   defer out.Flush()

   flag.Parse()
   if flag.NArg() > 0 { n,_ = strconv.Atoi( flag.Arg(0) ) }

   iub := []Acid{
      {prob: 0.27, sym: 'a'},
      {prob: 0.12, sym: 'c'},
      {prob: 0.12, sym: 'g'},
      {prob: 0.27, sym: 't'},
      {prob: 0.02, sym: 'B'},
      {prob: 0.02, sym: 'D'},
      {prob: 0.02, sym: 'H'},
      {prob: 0.02, sym: 'K'},
      {prob: 0.02, sym: 'M'},
      {prob: 0.02, sym: 'N'},
      {prob: 0.02, sym: 'R'},
      {prob: 0.02, sym: 'S'},
      {prob: 0.02, sym: 'V'},
      {prob: 0.02, sym: 'W'},
      {prob: 0.02, sym: 'Y'},
   }

   homosapiens := []Acid{
      {prob: 0.3029549426680, sym: 'a'},
      {prob: 0.1979883004921, sym: 'c'},
      {prob: 0.1975473066391, sym: 'g'},
      {prob: 0.3015094502008, sym: 't'},
   }

   alu := []byte(
      "GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG" +
         "GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA" +
         "CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT" +
         "ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA" +
         "GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG" +
         "AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC" +
         "AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA")

   out.WriteString(">ONE Homo sapiens alu\n")
   Repeat(alu, 2*n)
   out.WriteString(">TWO IUB ambiguity codes\n")
   Random(iub, 3*n)
   out.WriteString(">THREE Homo sapiens frequency\n")
   Random(homosapiens, 5*n)
}


type buffer []byte

func (b *buffer) Flush() {
   p := *b
   if len(p) > 0 {
      os.Stdout.Write(p)
   }
   *b = p[0:0]
}

func (b *buffer) WriteString(s string) {
   p := b.NextWrite(len(s))
   copy(p, s)
}

func (b *buffer) NextWrite(n int) []byte {
   p := *b
   if len(p)+n > cap(p) {
      b.Flush()
      p = *b
   }
   out := p[len(p) : len(p)+n]
   *b = p[:len(p)+n]
   return out
}
