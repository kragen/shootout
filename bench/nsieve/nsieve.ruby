#!/usr/bin/ruby
# -*- mode: ruby -*-
# $Id: nsieve.ruby,v 1.1 2005-03-23 06:11:41 bfulgham Exp $
# http://shootout.alioth.debian.org/
#
# Contributed by Christopher Williams

def nsieve(m)
  is_prime = Array.new(m, true)
  count = 0
  2.upto(m) do |i|
    if is_prime[i]
      k = 2 * i
      while k <= m
        is_prime[k] = false
	k+= i
      end
      count += 1
    end
  end
  return count
end

n = (ARGV[0] || 2).to_i
n = 2 if (n < 2) 

m = (1<<n)*10000
printf("Primes up to %8d%8d\n", m, nsieve(m))

m = (1<<n-1)*10000
printf("Primes up to %8d%8d\n", m, nsieve(m))

m = (1<<n-2)*10000
printf("Primes up to %8d%8d\n", m, nsieve(m))

