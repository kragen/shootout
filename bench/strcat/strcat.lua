-- $Id: strcat.lua,v 1.1 2004-05-19 18:13:34 bfulgham Exp $
-- http://www.bagley.org/~doug/shootout/
-- from Roberto Ierusalimschy

-- this version uses a custom string buffer

------------------------------------------------------------------
-- Buffer library
------------------------------------------------------------------

Buffer = {n=0}

function Buffer:new ()
  local new = {}
  for k,v in self do new[k] = v end
  return new
end

function Buffer:add (s)
  tinsert(self, s)
  local i = self.n
  for i=self.n-1, 1, -1 do
    if strlen(self[i]) > strlen(self[i+1]) then break end
    local top = tremove(self)
    self[i] = self[i]..top
  end
end

function Buffer:close ()
  for i=self.n-1, 1, -1 do
    local top = tremove(self)
    self[i] = self[i]..top
  end
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
io.write(strlen(buff:close()), "\n")
