-- $Id: wordfreq.lua,v 1.1 2004-05-19 18:14:18 bfulgham Exp $
-- http://www.bagley.org/~doug/shootout/
-- implemented by: Roberto Ierusalimschy

-- this version reads input line by line and so it is
-- noticably slower than the version that reads the
-- input in blocks.

local words = {}   -- list of all words (for sorting)
local count = {}   -- count occurrences of each word

while 1 do
  local line = read()
  if line == nil then break end
  gsub(strlower(line), "(%l+)", function (w)
    local cw = %count[w]
    if cw == nil then     -- first occurrence?
      cw = 0
      tinsert(%words, w)
    end
    %count[w] = cw + 1
  end)
end

sort(words, function (a,b)
  return  %count[a] > %count[b]  or
         (%count[a] == %count[b] and a > b)
end)

for i=1,getn(words) do
  local w = words[i]
  io.write(format("%7d\t%s\n", count[w], w))
end
