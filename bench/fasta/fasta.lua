-- The Great Computer Language Shootout
-- http://shootout.alioth.debian.org/
--
-- contributed by Isaac Gouy

-- The usual pseudo-random number generator

local IM = 139968
local IA = 3877
local IC = 29573
local Last = 42

local function random(max)
   Last = math.mod((Last * IA + IC), IM)
   return( (max * Last) / IM ) 
end


-- Weighted selection from alphabet

local function makeCumulative(a)
   local cp = 0;
   for i,v in ipairs(a) do 
      cp = cp + v.p; 
      a[i].p = cp 
   end
end

local function selectRandom(a)
   local r = random(1)
   for i,v in ipairs(a) do 
      if r < v.p then return v.c end 
   end
end


-- Generate and write FASTA format

local function makeRandomFasta(id,desc,a,n)
   io.write(">",id," ",desc,"\n")
    
   local todo, length = n, 60
   while todo > 0 do
      local m
      if todo < length then m = todo else m = length end            
      for _ = 1,m do io.write(selectRandom(a)) end
      io.write("\n")  
      todo = todo - length     
   end   
   io.write("\n")
end


local function makeRepeatFasta(id,desc,s,n)
   io.write(">",id," ",desc,"\n")
    
   local todo, length, k, kn = n, 60, 1, string.len(s)
   while todo > 0 do
      local j, m = 1
      if todo < length then m = todo else m = length end            
      while j <= m do 
         if k > kn then k = 1 end
         io.write( string.sub(s,k,k) );
         j = j + 1; k = k + 1
      end
      io.write("\n")  
      todo = todo - length     
   end   
end


-- Main -- define alphabets, make 3 fragments

local alu = 
   "GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG" ..
   "GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA" ..
   "CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT" ..
   "ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA" ..
   "GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG" ..
   "AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC" ..
   "AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA"


local iub = { 
    { c = "a", p = 0.27 }
   ,{ c = "c", p = 0.12 }
   ,{ c = "g", p = 0.12 }
   ,{ c = "t", p = 0.27 }

   ,{ c = "B", p = 0.02 }
   ,{ c = "D", p = 0.02 }
   ,{ c = "H", p = 0.02 }
   ,{ c = "K", p = 0.02 }
   ,{ c = "M", p = 0.02 }
   ,{ c = "N", p = 0.02 }
   ,{ c = "R", p = 0.02 }
   ,{ c = "S", p = 0.02 }
   ,{ c = "V", p = 0.02 }
   ,{ c = "W", p = 0.02 }
   ,{ c = "Y", p = 0.02 }
  }       
makeCumulative(iub)       


local homosapiens = { 
    { c = "a", p = 0.3029549426680 }
   ,{ c = "c", p = 0.1979883004921 }
   ,{ c = "g", p = 0.1975473066391 }
   ,{ c = "t", p = 0.3015094502008 }
  }
makeCumulative(homosapiens)

 
local n = tonumber(arg and arg[1]) or 1000

makeRepeatFasta('ONE','Homo sapiens alu',alu,n*2)

makeRandomFasta('TWO','IUB ambiguity codes',iub,n*3)

makeRandomFasta('THREE','Homo sapiens frequency',homosapiens,n*5)
