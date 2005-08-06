-- The Great Computer Language Shootout
-- http://shootout.alioth.debian.org/
--
-- contributed by Isaac Gouy


local function link(n)
   local message, next = 0

   if n-1 > 0 then
      next = coroutine.create(link) 
      coroutine.resume(next,n-1)
   end     
   coroutine.yield()

   while true do
      if next then
         _,message = coroutine.resume(next)
      end   
   
      coroutine.yield(message + 1)   
   end
end


local n = tonumber(arg[1]) or 10
local count, message = 0, 0
local chain = coroutine.create(link)

coroutine.resume(chain,500)
for j = 1,n do
   _,message = coroutine.resume(chain)
   count = count + message
end
io.write(count, "\n")
