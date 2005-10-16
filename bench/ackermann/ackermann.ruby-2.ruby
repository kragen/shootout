#!/usr/bin/ruby
# -*- mode: ruby -*-
# ackermann.rb optimized, Jeremy Echols (original author unknown)

def ack(m, n)
    return n + 1 if m == 0
    return ack(m - 1, 1) if n == 0
    ack(m - 1, ack(m, n - 1))
end

n = ARGV.shift.to_i || 1
puts "Ack(3,#{n}): #{ack(3, n)}"
