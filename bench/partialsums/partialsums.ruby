# ----------------------------------------------------------------------
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Based on D language implementation by Dave Fladebo
#
# Contributed by Anthony Borla
# ----------------------------------------------------------------------

n = (ARGV.shift || 1).to_i

sum = Array.new(9, 0.0) ; alt = 1.0 ; d = 1.0

n.times do
  d2 = d * d ; d3 = d2 * d ; ds = Math.sin(d) ; dc = Math.cos(d)

  sum[0] += (2 / 3.0) ** (d - 1.0)
  sum[1] += 1 / Math.sqrt(d)
  sum[2] += 1 / (d * (d + 1))
  sum[3] += 1 / (d3 * ds * ds)
  sum[4] += 1 / (d3 * dc * dc)
  sum[5] += 1 / d
  sum[6] += 1 / (d2)
  sum[7] += alt / d
  sum[8] += alt / (2 * d - 1)

  alt = -alt ; d += 1.0
end

printf("%.9f\t(2/3)^k\n", sum[0])
printf("%.9f\tk^-0.5\n", sum[1])
printf("%.9f\t1/k(k+1)\n", sum[2])
printf("%.9f\tFlint Hills\n", sum[3])
printf("%.9f\tCookson Hills\n", sum[4])
printf("%.9f\tHarmonic\n", sum[5])
printf("%.9f\tRiemann Zeta\n", sum[6])
printf("%.9f\tAlternating Harmonic\n", sum[7])
printf("%.9f\tGregory\n", sum[8])

