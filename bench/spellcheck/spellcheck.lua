-- $Id: spellcheck.lua,v 1.1 2004-05-19 18:13:26 bfulgham Exp $
-- http://www.bagley.org/~doug/shootout/
-- based on code from Roberto Ierusalimschy

assert(readfrom("Usr.Dict.Words"))
local dict = {}
while 1 do
  local line = read()
  if line == nil then break end
  dict[line] = 1
end
readfrom()    -- closes dictionary

while 1 do
  local word = read()
  if word == nil then break end
  if not dict[word] then print(word) end
end
