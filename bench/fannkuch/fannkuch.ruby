#!/usr/bin/ruby
#
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# fannkuch in Ruby
# Contributed by Glenn Parker, March 2005

def permute(size, &block)
  def permute1(head, tail, &block)
    tail.length.times do |i|
      head.push(tail.delete_at(i))
      if tail.empty?
	yield head.dup
      else
	permute1(head, tail, &block)
      end
      tail.insert(i, head.pop)
    end
  end

  permute1([], (1..size).to_a, &block)
end

N = (ARGV[0] || 1).to_i

maxflips = 0
permute(N) do |list|
  flips = 0
  while (count = list.first) != 1
    list[0...count] = list[0...count].reverse!
    flips += 1
  end
  maxflips = flips if maxflips < flips
end

puts "Pfannkuchen(#{N}) = #{maxflips}"

