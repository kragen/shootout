// ---------------------------------------------------------------------
// The Great Computer Language Shootout
// http://shootout.alioth.debian.org/
// 
// Use JRE 1.4 features only [JRE 1.5 'printf' would have helped better
// streamline code]
//
// Contributed by Anthony Borla
// ---------------------------------------------------------------------

import java.text.DecimalFormat

def main()
{
  n = Integer.parseInt(args[0])

  s0 = s1 = s2 = s3 = s4 = s5 = s6 = s7 = s8 = 0.0D ; alt = 1.0D ; d = 1.0D

  while (d <= n)
  {
    d2 = d * d ; d3 = d2 * d ; ds = Math.sin(d) ; dc = Math.cos(d)

    s0 += (2.0 / 3.0) ** (d - 1.0)
    s1 += 1.0 / Math.sqrt(d)
    s2 += 1.0 / (d * (d + 1.0))
    s3 += 1.0 / (d3 * ds * ds)
    s4 += 1.0 / (d3 * dc * dc)
    s5 += 1.0 / d
    s6 += 1.0 / d2
    s7 += alt / d
    s8 += alt / (2.0 * d - 1.0)

    alt = -alt ; d += 1.0 
  }

  fmt = new DecimalFormat("##0.000000000")

  result = fmt.format(s0) ; println "${result}\t(2/3)^k"
  result = fmt.format(s1) ; println "${result}\tk^-0.5"
  result = fmt.format(s2) ; println "${result}\t1/k(k+1)"
  result = fmt.format(s3) ; println "${result}\tFlint Hills"
  result = fmt.format(s4) ; println "${result}\tCookson Hills"
  result = fmt.format(s5) ; println "${result}\tHarmonic"
  result = fmt.format(s6) ; println "${result}\tRiemann Zeta"
  result = fmt.format(s7) ; println "${result}\tAlternating Harmonic"
  result = fmt.format(s8) ; println "${result}\tGregory"
}

// --------------------------------

main()

