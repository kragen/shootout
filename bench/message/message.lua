-- The Computer Language Shootout
-- http://shootout.alioth.debian.org/
-- contributed by Mike Pall

local co = coroutine
local create, resume, yield = co.create, co.resume, co.yield
if co.cstacksize then co.cstacksize(1) end -- Use minimum C stack.

local function link(n)
  if n > 1 then
    local thr = create(link)
    resume(thr, n-1)
    yield()
    repeat
      local ok, n = resume(thr)
      yield(n+1)
    until false
  else
    repeat yield(1) until false
  end
end

local N = tonumber(arg and arg[1]) or 10
local thr = create(link)
resume(thr, 500)
local count = 0
for i = 1,N do
  local ok, n = resume(thr)
  count = count + n
end
io.write(count, "\n")

