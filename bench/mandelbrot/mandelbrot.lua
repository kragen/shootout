-- The Great Computer Language Shootout
-- http://shootout.alioth.debian.org/
--
-- contributed by Isaac Gouy

local width = tonumber(arg and arg[1]) or 100
local height = width
local m, byte, bitnum, limit2 = 50, 0, 7, 4.0
local Zr, Zi, Cr, Ci, Tr, Ti

io.write("P4\n", width, " ", height, "\n")

for y=0,height-1 do
   for x=0,width-1 do

      Zr, Zi = 0.0, 0.0
      Cr = 2*x / width - 1.5
      Ci = 2*y / height - 1

      for i=1,m do
         Tr = Zr*Zr - Zi*Zi + Cr
         Ti = 2*Zr*Zi + Ci
         Zr = Tr; Zi = Ti
         if (Zr*Zr + Zi*Zi > limit2) then break end
      end

      if (Zr*Zr + Zi*Zi <= limit2) then 
         byte = byte + math.floor(2^bitnum)     
      end
      bitnum = bitnum - 1

      if (bitnum < 0) or (x == (width-1)) then 
         io.write(string.char(byte)); byte = 0; bitnum = 7            
      end
      
   end
end
