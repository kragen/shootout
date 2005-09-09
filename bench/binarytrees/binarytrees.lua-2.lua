-- The Great Computer Language Shootout
-- http://shootout.alioth.debian.org/
-- contributed by Mike Pall
-- alternative implementation with closures instead of tables

local function BottomUpTree(item, depth)
  if depth > 0 then
    local i = item + item
    depth = depth - 1
    local left, right = BottomUpTree(i-1, depth), BottomUpTree(i, depth)
    return function()
      return item + left() - right()
    end
  else
    return function()
      return item
    end
  end
end

local N = tonumber(arg and arg[1]) or 0
local mindepth = 4
local maxdepth = mindepth + 2
if maxdepth < N then maxdepth = N end

do
  local stretchdepth = maxdepth + 1
  local stretchtree = BottomUpTree(0, stretchdepth)
  io.write(string.format("stretch tree of depth %d\t check: %d\n",
    stretchdepth, stretchtree()))
end

local longlivedtree = BottomUpTree(0, maxdepth)

for depth=mindepth,maxdepth,2 do
  local iterations = 2 ^ (maxdepth - depth + mindepth)
  local check = 0
  for i=1,iterations do
    check = check + BottomUpTree(1, depth)() +
            BottomUpTree(-1, depth)()
  end
  io.write(string.format("%d\t trees of depth %d\t check: %d\n",
    iterations*2, depth, check))
end

io.write(string.format("long lived tree of depth %d\t check: %d\n",
  maxdepth, longlivedtree()))

