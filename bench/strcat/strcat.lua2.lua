-- $Id: strcat.lua2.lua,v 1.1 2004-05-19 18:13:34 bfulgham Exp $
-- http://www.bagley.org/~doug/shootout/

-- this version uses the native string concatenation operator

local n = tonumber((arg and arg[1]) or 1)
local str = ""
for i=1,n do
    str = str.."hello\n"
end
io.write(strlen(str), "\n")
