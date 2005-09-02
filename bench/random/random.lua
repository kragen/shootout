--- The Great Computer Language Shootout
-- http://shootout.alioth.debian.org/
--
-- contributed by: Roberto Ierusalimschy
-- modified by Mike Pall

local IM = 139968
local IA = 3877
local IC = 29573

local LAST = 42
local mod = math.mod
local function gen_random(max)
    LAST = mod((LAST * IA + IC), IM)
    return( (max * LAST) / IM )
end

local N = tonumber((arg and arg[1])) or 1
local result = 0
for i=1, N do
    result = gen_random(100)
end
io.write(string.format("%.9f\n", result))
