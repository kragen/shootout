-- The Great Computer Language Shootout
-- http://shootout.alioth.debian.org/
--
-- contributed by Isaac Gouy 


local function kFrequency(s,freq,k,frame)
   local n = string.len(s)-k+1      
   for i = frame,n,k do 
      local c = string.sub(s,i,i+k-1)
      record = freq[c]
      if record then
         record.count = record.count + 1
      else
         freq[c] = {key=c,count=1}
      end
   end
end

local function SortByFrequencyAndCode(a,b) 
   if a.count == b.count then
      return a.key < b.key
   else
      return a.count > b.count 
   end
end         

local function frequency(s,k)
   local freq = {}
   for i = 1,k do kFrequency(s,freq,k,i) end

   local sorted, sum = {}, 0
   for _,record in pairs(freq) do 
      table.insert(sorted,record) 
      sum = sum + record.count
   end

   table.sort(sorted, SortByFrequencyAndCode)
   
   for _,record in ipairs(sorted) do 
      local percent = (record.count/sum)*100
      io.write( string.format("%s %0.3f",record.key,percent), "\n") 
   end
   io.write("\n") 
end


local function count(sequence,fragment)
   local freq, record, count = {}
   local k = string.len(fragment)
   for i = 1,k do kFrequency(sequence,freq,k,i) end
   record = freq[fragment]
   if record then count = record.count else count = 0 end
   io.write( count, "\t", fragment, "\n")  
end


-- Read FASTA, extract fragment THREE, calculate frequencies & counts

for line in io.lines() do
   if string.sub(line,1,6) == ">THREE" then break end
end

local allLines = {""}
for line in io.lines() do
   local c = string.sub(line,1,1)
   if c == ">" then 
      break 
   elseif c ~= ";" then 
      table.insert(allLines,line)
   end
end
local sequence = string.upper(table.concat(allLines))


frequency(sequence,1) 
frequency(sequence,2) 

count(sequence,"GGT")
count(sequence,"GGTA")
count(sequence,"GGTATT")
count(sequence,"GGTATTTTAATT")
count(sequence,"GGTATTTTAATTTATAGT")
