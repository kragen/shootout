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

local function mkCumulative(a)
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

local function mkFastaFragment(id,desc,a,n)
   io.write(">",id," ",desc,"\n")
    
   local todo, length = n, 60
   while todo > 0 do
      local m
      if todo < length then m = todo else m = length end            
      for _ = 1,m do io.write(selectRandom(a)) end
      io.write("\n")  
      todo = todo - length     
   end   
end


-- Main -- define alphabets, make 5 fragments

dna1 = { 
    { c= "a", p= 0.3029549426680 }
   ,{ c= "c", p= 0.1979883004921 }
   ,{ c= "g", p= 0.1975473066391 }
   ,{ c= "t", p= 0.3015094502008 }
  }
mkCumulative(dna1)


dna2 = { 
    { c= "a", p= 0.250 }
   ,{ c= "c", p= 0.125 }
   ,{ c= "g", p= 0.125 }
   ,{ c= "t", p= 0.250 }

   ,{ c= "U", p= 0.019230769231 }
   ,{ c= "R", p= 0.019230769231 }
   ,{ c= "Y", p= 0.019230769231 }
   ,{ c= "K", p= 0.019230769231 }
   ,{ c= "M", p= 0.019230769231 }
   ,{ c= "S", p= 0.019230769231 }
   ,{ c= "W", p= 0.019230769231 }
   ,{ c= "B", p= 0.019230769231 }
   ,{ c= "D", p= 0.019230769231 }
   ,{ c= "H", p= 0.019230769231 }
   ,{ c= "V", p= 0.019230769231 }
   ,{ c= "N", p= 0.019230769231 }
   ,{ c= "-", p= 0.019230769231 }
  }       
mkCumulative(dna2)        



local n = tonumber(arg and arg[1]) or 1000

mkFastaFragment('TestOne','test fragment',dna2,n*1)
mkFastaFragment('TestTwo','test fragment',dna1,n*2)
mkFastaFragment('TestThree','test fragment',dna2,n*3)
mkFastaFragment('TestFour','test fragment',dna1,n*4)
mkFastaFragment('TestFive','test fragment',dna2,n*5)

-- vim: ts=4 ft=lua
