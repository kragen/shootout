-- $Id: ary.lua,v 1.1 2004-05-19 18:09:15 bfulgham Exp $
-- http://www.bagley.org/~doug/shootout/
-- Author: Roberto Ierusalimschy

local n = tonumber((arg and arg[1]) or 1)

local x, y = {}, {}
for i=1,n do
  x[i] = i
end

for j=n,1,-1 do
  y[j] = x[j]
end

io.write(y[n-1], "\n")
