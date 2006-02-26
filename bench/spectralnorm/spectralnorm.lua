-- The Computer Language Shootout
-- http://shootout.alioth.debian.org/
-- contributed by Isaac Gouy
-- modified by Adrian Sietsma


function A(i,j) local x = i+j;return 2/(x*x+x  +i+i+2) end

function Av(n,v)
   local Av = {}
   for i = 0,n-1 do
      local a = A(i,0)*v[0]
      for j = 1,n-1 do a = a + (A(i,j)*v[j]) end
      Av[i] = a
   end
   return Av
end

function Atv(n,v)
   local Atv = {}
   for i = 0,n-1 do
      local a = A(0,i)*v[0]
      for j = 1,n-1 do a = a + A(j,i)*v[j] end
      Atv[i] = a
   end
   return Atv
end

function AtAv(n,v)
   return Atv(n, Av(n,v))
end


local n = tonumber(arg and arg[1]) or 100

local u,v = {},{}
for i = 0,n-1 do u[i] = 1 end

for i = 1,10 do v = AtAv(n,u); u = AtAv(n,v) end

local vi = v[0]
local vBv,vv = u[0]*vi, vi*vi
for i = 1,n-1 do vi = v[i];vBv = vBv + u[i]*vi; vv = vv + vi*vi end

io.write( string.format("%0.9f", math.sqrt(vBv/vv) ), "\n")

