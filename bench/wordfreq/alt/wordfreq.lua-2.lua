-- $Id: wordfreq.lua-2.lua,v 1.1 2004-11-10 06:40:32 bfulgham Exp $
-- http://www.bagley.org/~doug/shootout/
-- implemented by: Roberto Ierusalimschy

-- this version reads the files in all at once, versus
-- line by line or in blocks.

local words = {}   -- list of all words (for sorting)
local count = {}   -- count occurrences of each word

-- read the whole input at once, and break it in words
gsub(strlower(read("*a")), "(%l+)", function (w)
  local cw = %count[w]
  if cw == nil then     -- first occurrence?
    cw = 0
    tinsert(%words, w)
  end
  %count[w] = cw + 1
end)

sort(words, function (a,b)
  return  %count[a] > %count[b]  or
         (%count[a] == %count[b] and a > b)
end)

for i=1,getn(words) do
  local w = words[i]
  io.write(format("%7d\t%s\n", count[w], w))
end
