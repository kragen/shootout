#!/usr/bin/ruby
#
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# nsieve benchmark in Ruby.
# Contributed by Glenn Parker, March 2005 

def sieve(m)
  flags = "\x1" * m
  count = 0
  pmax = m - 1
  2.step(pmax, 1) do |p|
    if flags[p] == 1
      count += 1
      p.step(pmax, p) do |mult|
        flags[mult] = 0
      end
    end
  end
  count
end

n = (ARGV[0] || 2).to_i
n.step(n - 2, -1) do |exponent|
  break if exponent < 0
  m = 2 ** exponent * 10_000
  count = sieve(m)
  printf "Primes up to %8d %8d\n", m, count
end
