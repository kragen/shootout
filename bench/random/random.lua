-- $Id: random.lua,v 1.1 2004-05-19 18:11:16 bfulgham Exp $
-- http://www.bagley.org/~doug/shootout/
-- implemented by: Roberto Ierusalimschy

local IM = 139968
local IA = 3877
local IC = 29573

LAST = 42
function gen_random(max)
    LAST = mod((LAST * %IA + %IC), %IM)
    return( (max * LAST) / %IM )
end

local N = tonumber((arg and arg[1])) or 1
for i=N, 2, -1 do
    gen_random(100)
end
io.write(format("%.9f\n", gen_random(100)))
