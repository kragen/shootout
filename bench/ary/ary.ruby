#!/usr/bin/ruby
# -*- mode: ruby -*-
# $Id: ary.ruby,v 1.2 2004-05-22 07:25:00 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/
# with help from Paul Brannan

n = Integer(ARGV.shift || 1)

x = Array.new(n)
y = Array.new(n, 0)

for i in 0 ... n
  x[i] = i + 1
end

for k in 0 .. 999
  (n-1).step(0,-1) do |i|
    y[i] = y.at(i) + x.at(i)
  end
end

puts "#{y.first} #{y.last}"
