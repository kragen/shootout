-- The Great Computer Language Shootout
-- http://shootout.alioth.debian.org/
-- contributed by Mike Pall

local IM = 139968
local IA = 3877
local IC = 29573
local Last = 42

local mod, sub, write = math.mod, string.sub, io.write

local function random(max)
  local y = mod(Last * IA + IC, IM)
  Last = y
  return (max * y) / IM
end

local function make_repeat_fasta(id, desc, s, n)
  write(">", id, " ", desc, "\n")
  local p, sn, s2 = 1, string.len(s), s..s
  for i=60,n,60 do
    write(sub(s2, p, p + 59), "\n")
    p = p + 60; if p > sn then p = p - sn end
  end
  local tail = mod(n, 60)
  if tail > 0 then write(sub(s2, p, p + tail-1), "\n") end
end

local function make_random_fasta(id, desc, f, n)
  write(">", id, " ", desc, "\n")
  for i=60,n,60 do for j=1,60 do f(random(1)) end; write("\n") end
  local tail = mod(n, 60)
  if tail > 0 then for j=1,tail do f(random(1)) end; write("\n") end
end

local function bisect(c, p, lo, hi)
  local n = hi - lo
  if n == 0 then return "write('"..c[hi].."')\n" end
  local mid = math.floor(n / 2)
  return "if r < "..p[lo+mid].." then\n"..bisect(c, p, lo, lo+mid)..
         "else\n"..bisect(c, p, lo+mid+1, hi).."end\n"
end

local function make_bisect(tab)
  local c, p, tn, sum = {}, {}, table.getn(tab), 0
  for i,row in ipairs(tab) do
    c[i] = row[1]
    sum = sum + row[2]
    p[i] = sum
  end
  return loadstring("local write = io.write\nreturn function(r)\n"..
                    bisect(c, p, 1, tn).."end\n")()
end

local alu =
  "GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG"..
  "GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA"..
  "CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT"..
  "ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA"..
  "GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG"..
  "AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC"..
  "AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA"

local iub = make_bisect{
  { "a", 0.27 },
  { "c", 0.12 },
  { "g", 0.12 },
  { "t", 0.27 },
  { "B", 0.02 },
  { "D", 0.02 },
  { "H", 0.02 },
  { "K", 0.02 },
  { "M", 0.02 },
  { "N", 0.02 },
  { "R", 0.02 },
  { "S", 0.02 },
  { "V", 0.02 },
  { "W", 0.02 },
  { "Y", 0.02 },
}

local homosapiens = make_bisect{
  { "a", 0.3029549426680 },
  { "c", 0.1979883004921 },
  { "g", 0.1975473066391 },
  { "t", 0.3015094502008 },
}

local N = tonumber(arg and arg[1]) or 1000
make_repeat_fasta('ONE', 'Homo sapiens alu', alu, N*2)
make_random_fasta('TWO', 'IUB ambiguity codes', iub, N*3)
make_random_fasta('THREE', 'Homo sapiens frequency', homosapiens, N*5)

