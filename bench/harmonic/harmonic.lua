-- The Great Computer Language Shootout
-- http://shootout.alioth.debian.org/
--
-- contributed by Isaac Gouy


local n = tonumber(arg and arg[1]) or 10000000

local d, partialSum = 0.0, 0.0
local i = 0

while i < n do
   d = d + 1.0
   partialSum = partialSum + (1.0/d)
   i = i + 1
end

io.write(string.format("%0.9f",partialSum), "\n")
