-- The Great Computer Language Shootout
-- http://shootout.alioth.debian.org/
--
-- contributed by Isaac Gouy


function A(i,j) return 1.0/((i+j)*(i+j+1) /2 +i+1) end

function Av(n,v) 
   local Av = {}
   for i = 0,n-1 do 
      Av[i] = 0
      for j = 0,n-1 do Av[i] = Av[i] + (A(i,j)*v[j]) end     
   end     
   return Av
end

function Atv(n,v) 
   local Atv = {}
   for i = 0,n-1 do 
      Atv[i] = 0
      for j = 0,n-1 do Atv[i] = Atv[i] + A(j,i)*v[j] end
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

local vBv,vv = 0,0
for i = 0,n-1 do vBv = vBv + u[i]*v[i]; vv = vv + v[i]*v[i] end

io.write( string.format("%0.9f", math.sqrt(vBv/vv) ), "\n")
