#!/usr/bin/ruby
# -*- mode: ruby -*-
# $Id: sieve.ruby,v 1.2 2004-06-17 05:37:50 bfulgham Exp $
# http://shootout.alioth.debian.org/
#
# Revised implementation by Paul Sanchez

NUM = Integer(ARGV.shift || 1)

max, flags = 8192, nil
flags0 = Array.new(max+1)
for i in 2 .. max
  flags0[i] = i
end

NUM.times do
    flags = flags0.dup
    for i in 2 .. Math.sqrt(max)
	next unless flags[i]
	# remove all multiples of prime: i
	(i+i).step(max, i) do |j|
	    flags[j] = nil
	end
    end
end

print "Count: ", flags.compact.size, "\n"
