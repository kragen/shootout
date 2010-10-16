/* The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * based on pidigits.c (by Paolo Bonzini & Sean Bartlett,
 *                      modified by Michael Mellor)
 *
 * contributed by The Go Authors.
 * flag.Arg hack by Isaac Gouy
 */

package main

import (
   "big"
   "flag"
   "fmt"
   "strconv"
)

var n = 0
var silent = false

var (
	tmp1  = big.NewInt(0)
	tmp2  = big.NewInt(0)
	y2    = big.NewInt(0)
	bigk  = big.NewInt(0)
	numer = big.NewInt(1)
	accum = big.NewInt(0)
	denom = big.NewInt(1)
	ten   = big.NewInt(10)
)

func extract_digit() int64 {
	if numer.Cmp(accum) > 0 {
		return -1
	}

	// Compute (numer * 3 + accum) / denom
	tmp1.Lsh(numer, 1)
	tmp1.Add(tmp1, numer)
	tmp1.Add(tmp1, accum)
	tmp1.DivMod(tmp1, denom, tmp2)

	// Now, if (numer * 4 + accum) % denom...
	tmp2.Add(tmp2, numer)

	// ... is normalized, then the two divisions have the same result.
	if tmp2.Cmp(denom) >= 0 {
		return -1
	}

	return tmp1.Int64()
}

func next_term(k int64) {
	// TODO(eds) If big.Int ever gets a Scale method, y2 and bigk could be int64
	y2.SetInt64(k*2 + 1)
	bigk.SetInt64(k)

	tmp1.Lsh(numer, 1)
	accum.Add(accum, tmp1)
	accum.Mul(accum, y2)
	numer.Mul(numer, bigk)
	denom.Mul(denom, y2)
}

func eliminate_digit(d int64) {
	tmp := big.NewInt(0).Set(denom)
	accum.Sub(accum, tmp.Mul(tmp, big.NewInt(d)))
	accum.Mul(accum, ten)
	numer.Mul(numer, ten)
}

func printf(s string, arg ...interface{}) {
   if !silent {
      fmt.Printf(s, arg...)
   }
}

func main() {
   flag.Parse()
   if flag.NArg() > 0 { n,_ = strconv.Atoi( flag.Arg(0) ) }

   var m int // 0 <= m < 10
   for i, k := 0, int64(0); ; {
      d := int64(-1)
      for d < 0 {
         k++
         next_term(k)
         d = extract_digit()
      }

      printf("%c", d+'0')

      i++
      m = i % 10
      if m == 0 {
         printf("\t:%d\n", i)
      }
      if i >= n {
         break
      }
      eliminate_digit(d)
   }

   if m > 0 {
      printf("%s\t:%d\n", "          "[m:10], n)
   }
}
