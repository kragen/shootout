--- The Great Computer Lanuage Shootout
--  http://shootout.alioth.debian.org
--
-- Contributed by Mike Pall 

local width = tonumber(arg and arg[1]) or 100
local height = width
local m, limit2 = 50, 4.0

io.write("P4\n", width, " ", height, "\n")

for y=0,height-1 do
  for xb=0,width-1,8 do
    local bits = 0
    local xbb = xb+7
    for x=xb,xbb < width and xbb or width-1 do
      bits = bits + bits
      local Zr, Zi = 0.0, 0.0
      local Cr, Ci = 2*x / width - 1.5, 2*y / height - 1
      local Zrq, Ziq = Zr*Zr, Zi*Zi
      for i=1,m do
        Zr, Zi = Zrq - Ziq + Cr, 2*Zr*Zi + Ci
        Zrq, Ziq = Zr*Zr, Zi*Zi
        if Zrq + Ziq > limit2 then
          bits = bits + 1
          break
        end
      end
    end
    if xbb >= width then
      for x=width,xbb do bits = bits + bits + 1 end
    end
    io.write(string.char(255-bits))
  end
end
