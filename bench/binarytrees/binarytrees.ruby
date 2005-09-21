#!/usr/bin/ruby
# The Comptuer Language Shootout Benchmarks
# http://shootout.alioth.debian.org
#
# contributed by Jesse Millikan

class TreeNode
 def initialize(left, right, item)
  @left = left
  @right = right
  @item = item
 end

 def ItemCheck
  if @left == nil
   @item
  else
   @item + @left.ItemCheck - @right.ItemCheck
  end
 end
end

def BottomUpTree(item, depth)
 if depth > 0
  item_item = 2 * item
  depth -= 1
  TreeNode.new(
   BottomUpTree( item_item - 1, depth),
   BottomUpTree( item_item, depth),
   item)
 else
  TreeNode.new(nil, nil, item)
 end
end

max_depth = ARGV[0].to_i
min_depth = 4

max_depth = min_depth + 2 if min_depth + 2 > max_depth

stretch_depth = max_depth + 1
stretch_tree = BottomUpTree(0, stretch_depth)

puts "stretch tree of depth #{stretch_depth}\t check: #{stretch_tree.ItemCheck}"
stretch_tree = nil
GC.start # slightly faster

long_lived_tree = BottomUpTree(0, max_depth)

min_depth.step(max_depth + 1, 2) do |depth|  
 iterations = 2**(max_depth - depth + min_depth)
 check = 0

 for i in 1..iterations  # 1.upto(iterations) do |i|
  temp_tree = BottomUpTree(i, depth)
  check += temp_tree.ItemCheck

  temp_tree = BottomUpTree(-i, depth)
  check += temp_tree.ItemCheck
 end 

 puts "#{iterations * 2}\t trees of depth #{depth}\t check: #{check}"
end

puts "long lived tree of depth #{max_depth}\t check: #{long_lived_tree.ItemCheck}"

