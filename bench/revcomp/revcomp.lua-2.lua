-- The Computer Language Benchmarks Game
-- http://shootout.alioth.debian.org/
-- contributed by Mike Pall

local bit = require("bit")
local ffi = require("ffi")

ffi.cdef[[
typedef struct FILE FILE;
extern FILE *stdin, *stdout;
int _IO_getline_info(FILE *, char *, size_t, int, int, int *);
size_t _IO_file_xsputn(FILE *, const void *, size_t);
int putchar_unlocked(int);
int setvbuf(FILE *, char *, int, size_t);
int fflush(FILE *);
void *realloc(void *, size_t);
void free(void *);
]]

-- Generate a lookup table to map 2 chars in parallel to their complements.
local function genrev(map)
  local r = ffi.new("uint8_t[?]", 256)
  for i=0,255 do r[i] = i end
  for i=1,#map,2 do local f,t = string.byte(map, i, i+1); r[f]=t; r[f-32]=t end
  local rev = ffi.new("uint16_t[?]", 65536)
  for i=0,65535 do
    rev[i] = bit.lshift(r[bit.band(i, 255)], 8) + r[bit.rshift(i, 8)]
  end
  return rev
end

-- Reverse and translate a buffer, chop it up into lines and write to stdout.
local function writerev(seq, n, rev)
  local C = ffi.C
  local stdout, out = C.stdout, ffi.new("uint8_t[?]", 61); out[60] = 10
  local s, o = ffi.cast("uint16_t *", seq + n % 2), ffi.cast("uint16_t *", out)
  for i=bit.rshift(n,1)-30,0,-30 do
    for j=0,29 do o[29-j] = rev[s[i+j]] end
    C._IO_file_xsputn(stdout, out, 61)
  end
  local tail = n % 60
  if tail > 0 then
    for i=tail-1,0,-1 do C.putchar_unlocked(bit.rshift(rev[seq[i]], 8)) end
    C.putchar_unlocked(10)
  end
end

local C = ffi.C
local stdin, stdout = C.stdin, C.stdout
local inbuf, outbuf = ffi.new("char[?]", 2^20), ffi.new("char[?]", 2^20)
C.setvbuf(stdin, inbuf, 0, 2^20); C.setvbuf(stdout, outbuf, 0, 2^20)
local rev = genrev("aTcGbVdHgChDkMmKnNsSrYuAtAwWvByR")

-- Read each FASTA input sequence line-by-line into a growable buffer.
local sz = 2^20
local buf = ffi.cast("uint8_t *", C.realloc(nil, sz+256)); assert(buf ~= nil)
local m = C._IO_getline_info(stdin, buf, 256, 10, 0, nil)
local head = m ~= 0 and ffi.string(buf, m)
while head do
  C._IO_file_xsputn(stdout, head, #head); C.putchar_unlocked(10)
  local n = 0
  repeat
    local m = C._IO_getline_info(stdin, buf+n, 256, 10, 0, nil)
    if m == 0 then head = nil; break end
    if buf[n] == 62 then head = ffi.string(buf+n, m); break end
    n = n + m
    if n >= sz then
      sz = sz + sz
      buf = ffi.cast("uint8_t *", C.realloc(buf, sz+256)); assert(buf ~= nil)
    end
  until false
  writerev(buf, n, rev)
end

C.fflush(stdout)
C.free(buf)
