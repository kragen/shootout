-- $Id: random.lua,v 1.2 2004-06-12 16:19:43 bfulgham Exp $
-- http://www.bagley.org/~doug/shootout/
-- implemented by: Roberto Ierusalimschy

local IM = 139968
local IA = 3877
local IC = 29573

local LAST = 42
function gen_random(max)
    LAST = math.mod((LAST * IA + IC), IM)
    return( (max * LAST) / IM )
end

local N = tonumber((arg and arg[1])) or 1
local result = 0
for i=1, N do
    result = gen_random(100)
end
io.write(string.format("%.9f\n", result))
