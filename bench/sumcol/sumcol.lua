-- $Id: sumcol.lua,v 1.1 2004-05-19 18:13:43 bfulgham Exp $
-- http://www.bagley.org/~doug/shootout/

local sum = 0
local line = read()
while line ~= nil do
    sum = sum + line
    line = read()
end
io.write(sum, "\n")
