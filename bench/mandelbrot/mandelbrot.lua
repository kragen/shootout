-- The Great Computer Language Shootout
-- http://shootout.alioth.debian.org/
--
-- contributed by Isaac Gouy 

local width = tonumber(arg and arg[1]) or 100
local height = width
local m, bits, bitnum, limit2 = 50, 0, 0, 4.0
local isOverLimit = false
local Zr, Zi, Cr, Ci, Tr, Ti

io.write("P4\n", width, " ", height, "\n")

for y=0,height-1 do
   for x=0,width-1 do

      Zr, Zi = 0.0, 0.0
      Cr = 2*x / width - 1.5
      Ci = 2*y / height - 1

      i = 0
      repeat
         Tr = Zr*Zr - Zi*Zi + Cr
         Ti = 2*Zr*Zi + Ci
         Zr = Tr; Zi = Ti
         i = i + 1
         isOverLimit = Zr*Zr + Zi*Zi > limit2
      until isOverLimit or (i == m) 


      -- encode as bit value

      bits = bits * 2
      if not isOverLimit then bits = bits + 1 end
      bitnum = bitnum + 1

      if x == width - 1 then 
         for i = bitnum,7 do bits = bits * 2 end; bitnum = 8
      end


      if bitnum == 8 then
         io.write(string.char(bits)); bits = 0; bitnum = 0          
      end
      
   end
end
