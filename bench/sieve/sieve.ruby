#!/usr/bin/ruby
# -*- mode: ruby -*-
# $Id: sieve.ruby,v 1.1 2004-05-19 18:12:28 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

NUM = Integer(ARGV.shift || 1)

count = i = j = 0
flags0 = Array.new(8192,1)

NUM.times do
    count = 0
    flags = flags0.dup
    for i in 2 .. 8192
	next unless flags[i]
	# remove all multiples of prime: i
	(i+i).step(8192, i) do |j|
	    flags[j] = nil
	end
	count = count + 1
    end
end

print "Count: ", count, "\n"
