#!/usr/bin/lua
-- $Id: reversefile.lua,v 1.1 2004-05-19 18:12:18 bfulgham Exp $
-- http://www.bagley.org/~doug/shootout/

local lines = {}
local w = io.write
nl = 0

gsub(read("*a"), "([^\n]+\n)", function (l)
    %lines[nl] = l
    nl = nl + 1
end)

nl = nl - 1
for i=nl,0,-1 do
    w(lines[i])
end
