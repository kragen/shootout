-- $Id: strcat.lua,v 1.2 2004-06-12 16:19:44 bfulgham Exp $
-- http://shootout.alioth.debian.org
-- contributed by Roberto Ierusalimschy

-- this version uses a custom string buffer

------------------------------------------------------------------
-- Buffer library
------------------------------------------------------------------

Buffer = {""}

function Buffer:new ()
  local new = {}
  self.__index = self
  setmetatable(new, self)
  return new
end

function Buffer:add (s)
  table.insert(self, s)    -- push 's' into the the stack
  for i=table.getn(self)-1, 1, -1 do
    if string.len(self[i]) > string.len(self[i+1]) then
      break
    end
    self[i] = self[i] .. table.remove(self)
  end
end

function Buffer:close ()
  self[1] = table.concat(self)
  table.setn(self, 1)   -- now there is only one element
  return self[1]
end


------------------------------------------------------------------
-- Test
------------------------------------------------------------------

local n = tonumber((arg and arg[1]) or 1)
local buff = Buffer:new()
for i=1,n do
  buff:add("hello\n")
end
io.write(string.len(buff:close()), "\n")


