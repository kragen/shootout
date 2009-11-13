/* The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * contributed by The Go Authors.
 * based on pidigits.c (by Paolo Bonzini & Sean Bartlett,
 *                      modified by Michael Mellor)
 * flag.Arg hack by Isaac Gouy
 */

package main

import (
   "bignum";
   "flag";
   "fmt";
   "strconv";
)

var n = 0
var silent = false

var (
   tmp1 *bignum.Integer;
   tmp2 *bignum.Integer;
   numer = bignum.Int(1);
   accum = bignum.Int(0);
   denom = bignum.Int(1);
)

func extract_digit() int64 {
   if numer.Cmp(accum) > 0 {
      return -1;
   }

   // Compute (numer * 3 + accum) / denom
   tmp1 = numer.Shl(1);
   bignum.Iadd(tmp1, tmp1, numer);
   bignum.Iadd(tmp1, tmp1, accum);
   tmp1, tmp2 := tmp1.QuoRem(denom);

   // Now, if (numer * 4 + accum) % denom...
   bignum.Iadd(tmp2, tmp2, numer);

   // ... is normalized, then the two divisions have the same result.
   if tmp2.Cmp(denom) >= 0 {
      return -1;
   }

   return tmp1.Value();
}

func next_term(k int64) {
   y2 := k*2 + 1;

   tmp1 = numer.Shl(1);
   bignum.Iadd(accum, accum, tmp1);
   bignum.Iscale(accum, y2);
   bignum.Iscale(numer, k);
   bignum.Iscale(denom, y2);
}

func eliminate_digit(d int64) {
   bignum.Isub(accum, accum, denom.Mul1(d));
   bignum.Iscale(accum, 10);
   bignum.Iscale(numer, 10);
}

func printf(s string, arg ...) {
   if !silent {
      fmt.Printf(s, arg);
   }
}

func main() {
   flag.Parse();
   if flag.NArg() > 0 { n,_ = strconv.Atoi( flag.Arg(0) ) }

   var m int;   // 0 <= m < 10
   for i, k := 0, int64(0); ; {
      d := int64(-1);
      for d < 0 {
         k++;
         next_term(k);
         d = extract_digit();
      }

      printf("%c", d + '0');

      i++;
      m = i%10;
      if m == 0 {
         printf("\t:%d\n", i);
      }
      if i >= n {
         break;
      }
      eliminate_digit(d);
   }

   if m > 0 {
      printf("%s\t:%d\n", "          "[m : 10], n);
   }
}
