#!/usr/bin/ruby
# http://shootout.alioth.debian.org/
#
# Contributed by Christopher Williams, modified by Daniel South

n = (ARGV[0] || 10000000).to_i

partialSum = 0.0
(1..n).each {|i| partialSum += (1.0 / i) }

printf("%.9f\n", partialSum)

