-- The Computer Language Shootout
-- http://shootout.alioth.debian.org/
-- contributed by Sokolov Yura with ideas from Mike Pall (and Rici Lake)

local sub = string.sub
local concat = table.concat
local gsub = string.gsub
local reverse = string.reverse
local insert = table.insert
local write = io.write

local iubc = setmetatable({
  A="T", C="G", B="V", D="H", K="M", R="Y",
  a="T", c="G", b="V", d="H", k="M", r="Y",
  T="A", G="C", V="B", H="D", M="K", Y="R", U="A",
  t="A", g="C", v="B", h="D", m="K", y="R", u="A",
  N="N", S="S", W="W", n="N", s="S", w="W",
}, { __index = function(t, s)
  local r = t[sub(s, 1, 1)]..t[sub(s, 2)]; t[s] = r; return r end })

local function writerev(p)
  local rev = reverse(gsub(concat(p, ""), "(..?.?.?)", iubc))
  for i = 1,#rev,60 do
    write(sub(rev, i, i+59), "\n")
  end
end

local p = {}
for line in io.lines() do
  local c = sub(line, 1, 1)
  if c == ">" then
    writerev(p)
    p = {}
    write(line, "\n")
  elseif c ~= ";" then
    insert(p, line)
  end
end
writerev(p)