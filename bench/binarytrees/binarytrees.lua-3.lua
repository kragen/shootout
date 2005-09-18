--- The Great Computer Lanuage Shootout
--  http://shootout.alioth.debian.org
--
-- Contributed by Matthew Burke <shootout@bluedino.net>
--

local TreeNode = {}
TreeNode.__index = TreeNode

function TreeNode:create(item, left, right)
   local s = {}
   s.item = item
   s.left = left
   s.right = right
   setmetatable(s, self)
   return s
end

function TreeNode:itemCheck()
   if (self.left == nil) then
      return self.item
   else
      return self.item + self.left:itemCheck() - self.right:itemCheck()
   end
end

function TreeNode.bottomUpTree(item, depth)
   if (depth > 0) then
      return TreeNode:create(item,
                             TreeNode.bottomUpTree(2*item-1, depth-1),
                             TreeNode.bottomUpTree(2*item, depth-1))
   else
      return TreeNode:create(item)
   end
end


local minDepth = 4
local n = tonumber(arg and arg[1]) or (minDepth + 2)
local maxDepth = math.max(n, minDepth + 2)
local stretchDepth = maxDepth + 1

local check = (TreeNode.bottomUpTree(0, stretchDepth)):itemCheck()
io.write( string.format("stretch tree of depth %d\t  check: %d", stretchDepth, check), "\n")

local longLivedTree = TreeNode.bottomUpTree(0, maxDepth)

for depth = minDepth,maxDepth,2 do
   local iterations = 2 ^ (maxDepth - depth + minDepth)
   local check = 0
   for i = 1,iterations do
      check = check + (TreeNode.bottomUpTree(i,depth)):itemCheck()
      check = check + (TreeNode.bottomUpTree(-i,depth)):itemCheck()
   end
   io.write( string.format("%d\t  trees of depth %d\t  check: %d", iterations*2, depth, check), "\n")
end
io.write( string.format("long lived tree of depth %d\t  check: %d", maxDepth, longLivedTree:itemCheck()), "\n")
