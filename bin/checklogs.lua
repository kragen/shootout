#!/usr/bin/lua
-- Check Shootout log-files for missing content
-- 30 March 2005


-- get directory listing with log-files

local dirname = "./website/code/"

os.execute('cd '..dirname..'; ls *.log > ../../dir_list')

local f = assert(io.open("dir_list","r"))
local s = f:read("*all")
f:close()

os.execute('rm dir_list')



-- collect log-file names

local d = {}
for w in string.gfind(s,"[%p%d%a]+.log") do
   table.insert(d,w)
end


-- search log-files for empty logs

for i,name in ipairs(d) do
   local f = assert(io.open(dirname..name,"r"))
   local s = f:read("*all")
   f:close()

   local j,k = string.find(s,"PROGRAM OUTPUT")

   local extras = 16 -- the LF==============LF
   if k == nil then 
      print(name .. " <== no PROGRAM OUTPUT text in log")
   else
      if k+extras == string.len(s) then print(name) end
   end
end
