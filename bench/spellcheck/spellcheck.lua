-- $Id: spellcheck.lua,v 1.2 2004-05-25 02:26:33 bfulgham Exp $
-- http://www.bagley.org/~doug/shootout/
-- based on code from Roberto Ierusalimschy

assert(io.open("Usr.Dict.Words"))
local dict = {}
for line in io.lines("Usr.Dict.Words") do
  dict[line] = true
end

for word in io.lines() do
  if not dict[word] then print(word) end
end

