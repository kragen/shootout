-- The Computer Language Benchmarks Game
-- http://shootout.alioth.debian.org/
-- contributed by Bruno Massa

require"coroutine"

-- variables
local n                 = tonumber(arg[1])
local nthreads, threads = 503, {}
local id, token, ok     = 1, n, true

-- cache these to avoid global environment lookups
local yield, wrap       = coroutine.yield, coroutine.wrap

local thread_ring = function(id, mytoken)
  local nextid
  if id == nthreads then
    nextid = 1
  else
    nextid = id + 1
  end

  while true do
    if mytoken == 0 then
      print(id)
      return false
    end
    id, mytoken = yield(true, nextid, mytoken - 1)
  end
end

-- create all threads
for id = 1, nthreads do
  threads[id] = wrap(thread_ring)
end

-- send the token
while ok do
  ok, id, token = threads[id](id, token)
end