#!/usr/bin/ruby
# -*- mode: ruby -*-
# $Id: ary.ruby,v 1.1 2004-05-19 18:09:16 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

n = Integer(ARGV.shift || 1)

i = 0
x = Array.new(n)
y = Array.new(n)
last = n-1

for i in 0 .. n-1
    x[i] = i
end

last.step(0,-1) do |i|
    y[i] = x[i]
end

puts y[last]
