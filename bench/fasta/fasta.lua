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
   for k,v in pairs(a) do cp = cp + v; a[k] = cp end
end

local function selectRandom(a)
   local r = random(1)
   for k,v in pairs(a) do 
      if r < v then return k end 
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
   a = 0.3029549426680
  ,c = 0.1979883004921
  ,g = 0.1975473066391
  ,t = 0.3015094502008 
  }
mkCumulative(dna1)

dna2 = { 
    a = 0.25
   ,c = 0.125
   ,g = 0.125
   ,t = 0.25
   ,U = 0.019230769231
   ,R = 0.019230769231
   ,Y = 0.019230769231
   ,K = 0.019230769231
   ,M = 0.019230769231
   ,S = 0.019230769231
   ,W = 0.019230769231
   ,B = 0.019230769231
   ,D = 0.019230769231
   ,H = 0.019230769231
   ,V = 0.019230769231
   ,N = 0.019230769231
   ,["-"] = 0.019230769231
   }          
mkCumulative(dna2)          

local n = tonumber(arg and arg[1]) or 1000

mkFastaFragment('TestOne','test fragment',dna2,n)
mkFastaFragment('TestTwo','test fragment',dna1,n)
mkFastaFragment('TestThree','test fragment',dna2,n)
mkFastaFragment('TestFour','test fragment',dna1,n)
mkFastaFragment('TestFive','test fragment',dna2,n)
