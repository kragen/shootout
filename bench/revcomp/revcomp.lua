-- The Great Computer Language Shootout
-- http://shootout.alioth.debian.org/
--
-- contributed by Isaac Gouy 


-- define IUB ambiguity code complements

local iubComplement = { 
    A = "T"
   ,C = "G"
   ,G = "C"
   ,T = "A"

   ,B = "V"
   ,D = "H"
   ,H = "D"
   ,K = "M"
   ,M = "K"
   ,R = "Y"
   ,V = "B"
   ,Y = "R"
   }
  

local function writeFasta(desc,a)
   io.write(desc,"\n")
    
   local n, m, length, i = string.len(a), 0, 60, 1
   while i <= n do
      m = m + length 
      if n < m then m = n end            
      while i <= m do 
         io.write( string.sub(a,i,i) );
         i = i + 1
      end
      io.write("\n")    
   end   
end


local function reverseComplement(a)
   local u = string.upper(a)
   local t = {""}
   for i = string.len(u),1,-1 do 
      local c = string.sub(u,i,i)
      table.insert(t, (iubComplement[c] or c))
   end
   return table.concat(t)
end


-- Read FASTA, extract fragment, write reverse complement

local desc = ""
local fragment = {""}
for line in io.lines() do
   local c = string.sub(line,1,1)

   if c == ">" then 
      if string.len(desc) > 0 then 
         writeFasta(desc, reverseComplement( table.concat(fragment) ))
         fragment = {""}
      end   
      desc = line   

   elseif c ~= ";" then 
      table.insert(fragment,line)   
   end
end

if string.len(desc) > 0 then 
   writeFasta(desc, reverseComplement( table.concat(fragment) ))
end
