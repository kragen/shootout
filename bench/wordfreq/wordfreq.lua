-- $Id: wordfreq.lua,v 1.3 2004-07-03 05:36:11 bfulgham Exp $
-- http://shootout.alioth.debian.org
-- contributed by Roberto Ierusalimschy

-- this version reads 4K chunks of input at a time

local words = {}   -- list of all words (for sorting)
local count = {}   -- count occurrences of each word

local BUFSIZE = 2^12

while true do
  local lines, rest = io.read(BUFSIZE, "*l")
  if lines == nil then break end
  lines = lines..(rest or '')    -- ensures whole lines
  for w in string.gfind(string.lower(lines), "(%l+)") do
    local cw = count[w]
    if not cw then     -- first occurrence?
      cw = 0
      table.insert(words, w)
    end
    count[w] = cw + 1
  end
end

table.sort(words, function (a,b)
  return  count[a] > count[b]  or (count[a] == count[b] and a > b)
end)

for i=1,table.getn(words) do
  local w = words[i]
  io.write(string.format("%7d %s\n", count[w], w))
end

