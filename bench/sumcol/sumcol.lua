-- $Id: sumcol.lua,v 1.2 2004-06-12 16:19:44 bfulgham Exp $
-- http://www.bagley.org/~doug/shootout/

local sum = 0
local line = io.read()

while line ~= nil do
    sum = sum + line
    line = io.read()
end
io.write(sum, "\n")
