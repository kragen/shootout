#!/usr/bin/lua
-- Cross check data file and log files
-- 15 April 2005, Isaac Gouy


-- Directory locations

local logdir = './website/code/'
local datadir = './website/data/'


-- 1 get directory listing with log-files

os.execute('cd '..logdir..'; ls *.log > ../../dir_list')
local f = assert(io.open("dir_list","r"))
local s = f:read("*all")
f:close()
-- os.execute('rm -f dir_list')
print("Got "..s)



-- 2 collect log-file names and report large log-files

print()
print("Check for log-files larger than 10,240 bytes")
print("============================================")
local lognames = {}
for _,_,_,b,_,_,_,name in string.gfind(s,"([%p%d%a]%) ([%d]+) ([%p%d%a]+) ([%d]+) ([%a]+) ([%d]+) ([%p%d]+) ([%p%d%a]+.log)") do
   print("Ehh..."..b.." was b, now "..name)
   local bytes = 0 + string.gsub(b, ",", "")
   if bytes > 10240 then print(name, b) end
   table.insert(lognames,name)    
end
print("\n")



-- 3 collect data.csv contents

local data = {}

local f = assert(io.open(datadir.."data.csv","r"))
while true do
   local line = f:read()
   if line == nil then break end

   local name
   local _,_,b,l,v = string.find(line,"([%w]+),([%w]+),([%d%s]+),")
   if b then
      if v == ' ' then 
         name = b.."-"..l..".log"     
      else
         name = b.."-"..l.."-"..v..".log"        
      end

      if string.find(line,"-1") then
         data[name] = -1  
      elseif string.find(line,"-2") then   
         data[name] = -2
      else
         data[name] = 0  
      end   
   end      
end
f:close()



-- 4 classify log files

local logs = {}
local extras = 16 -- the LF==============LF

for _,name in ipairs(lognames) do
   print("Checking " .. name)
   local f = assert(io.open(logdir..name,"r"))
   local s = f:read("*all")
   f:close()

   local j,k = string.find(s,"PROGRAM OUTPUT")

   if string.find(s,"KILLED") then
      logs[name] = -1  

   elseif string.find(s,"FAILED") or string.find(s,"Permission") then
      logs[name] = -2  
                  
   -- missing program output      
   elseif k == nil or k+extras == string.len(s) then
      logs[name] = -3        
      
   else 
      logs[name] = 0     
   end
end



-- 9

print("Log file exists - NO data.csv row")
print("========================================")

local a = {}
for k,v in pairs(logs) do
   print("Checking "..k)
   if data[k] == nil then table.insert(a,k) end
end

table.sort(a)
for i,k in ipairs(a) do print(k) end
print("\n")



-- 10

print("NO log file - data.csv row exists")
print("========================================")

local a = {}
for k,v in pairs(data) do
   if logs[k] == nil then table.insert(a,k) end
end

table.sort(a)
for i,k in ipairs(a) do print(k) end
print("\n")



-- 5

print("Error in log file - NO error in data.csv")
print("========================================")

local a = {}
for k,v in pairs(logs) do
   if v == -2 and data[k] ~= -2 then table.insert(a,k) end
end

table.sort(a)
for i,k in ipairs(a) do print(k) end
print("\n")



-- 6

print("No error in log file - ERROR in data.csv")
print("========================================")

local a = {}
for k,v in pairs(logs) do
   if v == 0 and data[k] == -2 then
      table.insert(a,k) end
end

table.sort(a)
for i,k in ipairs(a) do print(k) end
print("\n")



-- 7

print("NO Program output in log file - data.csv OK")
print("======================================================")

local a = {}
for k,v in pairs(logs) do
   if v == -3 and data[k] == 0 then table.insert(a,k) end
end

table.sort(a)
for i,k in ipairs(a) do print(k) end
print("\n")



-- 8

print("log file *may be* ok - TIMEOUT data.csv")
print("======================================================")

local a = {}
for k,v in pairs(data) do
   if v == -1 and logs[k] == 0 then table.insert(a,k) end
end

table.sort(a)
for i,k in ipairs(a) do print(k) end
print("\n")

