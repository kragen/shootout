-- The Computer Language Benchmarks Game
-- http://shootout.alioth.debian.org/
-- contributed by Mike Pall

local bit = require("bit")
local ffi = require("ffi")

ffi.cdef[[
typedef struct FILE FILE;
int _IO_getline_info(FILE *, char *, size_t, int, int, int *);
int setvbuf(FILE *stream, char *buf, int mode, size_t size);
extern FILE *stdin, *stdout;
void *realloc(void *ptr, size_t size);
void free(void *ptr);
]]

-- Generate a specialized hash for k-nucleotides. k = 1, 2, 3, 4, 6, 12 or 18.
local function khash(k)
  local s
  if k == 1 then
    s = "h = band(b[i],6)"
  elseif k < 4 then
    s = "h = bor(band(b[i],6), shl(band(b[i+1],6),2)) "
    if k == 3 then s = s.."h = bor(h, shl(band(b[i+2],6),4))" end
  else
    s = "do local w=cast('int32_t *', b+i); h=band(shr(w[0],1),0x03030303) "
    if k == 6 then
      s = s..[[
h = bor(h, shl(band(b[i+4],6),1)); h = bor(h, shl(band(b[i+5],6),3)) ]]
    elseif k >= 12 then
      s = s.."h = bor(h, band(shl(w[1],1),0x0c0c0c0c)) "
      if k == 12 then
	s = s.."h = bor(h, band(shl(w[2],3),0x30303030))"
      else
	s = s..[[
local h2 = bor(band(shl(w[2],3),0x30303030), band(shl(w[3],5),0xc0c0c0c0))
h = bor(h, h2) + 2^32*bor(band(b[i+16],6), shl(band(b[i+17],6),2))]]
      end
    end
    s = s.." end"
  end
  return s
end

local function freqdefault()
  return 0
end

-- Count all k-nucleotide sequences.
local function kcount(seq, n, k, frag)
  local h = khash(k)
  local s = string.format([[
    local ffi, bit, b, f, frag = ...
    local cast = ffi.cast
    local bor, band, shl, shr = bit.bor, bit.band, bit.lshift, bit.rshift
    for frame=0,%d do
      for i=frame,%d,%d do local h; %s f[h] = f[h] + 1 end
    end ]], k-1, n-k, k, h)
  if frag then
    s = s.."local i = 0; b = ffi.cast('uint8_t *', frag); "..h.." return f[h]"
  else
    s = s.."return f"
  end
  local f = setmetatable({}, { __index = freqdefault })
  return loadstring(s)(ffi, bit, seq, f, frag)
end

-- Count all k-nucleotide sequences and print the frequency of a fragment.
local function kfrag(seq, n, frag)
  io.write(kcount(seq, n, #frag, frag), "\t", frag, "\n")
end

-- Count all k-nucleotide sequences and print them in order of frequency.
local function ksort(seq, n, k)
  local f = kcount(seq, n, k)
  local sfreq, sn, sum = {}, 1, 0
  for c,v in pairs(f) do sfreq[sn] = c; sn = sn + 1; sum = sum + v end
  table.sort(sfreq, function(a, b) return f[a]==f[b] and a>b or f[a]>f[b] end)
  local m = {[0]="A","C","T","G"}
  for _,c in ipairs(sfreq) do
    local s = ""; for i=1,2*k,2 do s = s..m[bit.band(bit.rshift(c,i),3)] end
    io.write(string.format("%s %0.3f\n", s, (f[c]*100)/sum))
  end
  io.write("\n")
end

-- Read the third FASTA sequence line-by-line into a growable buffer.
local function fasta_read()
  local C = ffi.C
  local stdin, iobuf = C.stdin, ffi.new("char[?]", 2^20)
  C.setvbuf(stdin, iobuf, 0, 2^20)
  local sz = 2^20
  local buf = ffi.cast("uint8_t *", C.realloc(nil, sz+256)); assert(buf ~= nil)
  while C._IO_getline_info(stdin, buf, 256, 10, 0, nil) ~= 0 and
	not (buf[0] == 62 and buf[2] == 72) do end -- Wait for ">THREE".
  local n = 0
  repeat
    local m = C._IO_getline_info(stdin, buf+n, 256, 10, 0, nil)
    if m == 0 or buf[n] == 62 then break end
    n = n + m
    if n >= sz then
      sz = sz + sz
      buf = ffi.cast("uint8_t *", C.realloc(buf, sz+256)); assert(buf ~= nil)
    end
  until false
  return buf, n
end

local buf, n = fasta_read()
ksort(buf, n, 1)
ksort(buf, n, 2)
kfrag(buf, n, "GGT")
kfrag(buf, n, "GGTA")
kfrag(buf, n, "GGTATT")
kfrag(buf, n, "GGTATTTTAATT")
kfrag(buf, n, "GGTATTTTAATTTATAGT")
ffi.C.free(buf)
