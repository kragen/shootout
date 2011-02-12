-- The Computer Language Benchmarks Game
-- http://shootout.alioth.debian.org/
-- contributed by Mike Pall

local ffi = require("ffi")

ffi.cdef[[
typedef struct FILE FILE;
extern FILE *stdout;
size_t _IO_file_xsputn(FILE *, const void *, size_t);
int putchar_unlocked(int);
int setvbuf(FILE *, char *, int, size_t);
int fflush(FILE *);
]]

local function fasta_repeat(s, n)
  local C, stdout = ffi.C, ffi.C.stdout
  local s2, j, sn = s..s, 0, #s
  local p = ffi.new("const char *", s2)
  for i=60,n,60 do
    C._IO_file_xsputn(stdout, p+j, 60); C.putchar_unlocked(10)
    j = j + 60; if j >= sn then j = j - sn end
  end
  local tail = n % 60
  if tail > 0 then
    C._IO_file_xsputn(stdout, p+j, tail); C.putchar_unlocked(10)
  end
end

local rstate = ffi.new("struct { double d; int i;}", 42, 0)
local function random()
  local m = rstate.d * 3877 + 29573; rstate.i = m * (502748801 / 2^46)
  local y = m - rstate.i * 139968; rstate.d = y
  return y
end

local function genlookup(t)
  local lookup = ffi.new("uint8_t[?]", 139968)
  local j, p, s = 1, t[1]*139968, string.byte(t[0], 1)
  for i=0,139967 do
    if p < i then j = j+1; p = p + t[j]*139968; s = string.byte(t[0], j) end
    lookup[i] = s
  end
  return lookup
end

local function fasta_random(t, n)
  local C, stdout = ffi.C, ffi.C.stdout
  local lookup = genlookup(t)
  local buf = ffi.new("uint8_t[?]", 61); buf[60] = 10
  for i=60,n,60 do
    for j=0,59 do buf[j] = lookup[random()] end
    C._IO_file_xsputn(stdout, buf, 61)
  end
  local tail = n % 60
  if tail > 0 then
    for j=0,tail-1 do buf[j] = lookup[random()] end
    buf[tail] = 10
    C._IO_file_xsputn(stdout, buf, tail+1)
  end
end

local alu =
  "GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG"..
  "GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA"..
  "CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT"..
  "ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA"..
  "GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG"..
  "AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC"..
  "AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA"

local iub = {
  [0] = "acgtBDHKMNRSVWY",
  0.27,0.12,0.12,0.27,0.02,0.02,0.02,0.02,0.02,0.02,0.02,0.02,0.02,0.02,0.02
}

local homosapiens = {
  [0] = "acgt",
  0.3029549426680, 0.1979883004921, 0.1975473066391, 0.3015094502008
}

local N = tonumber(arg and arg[1]) or 1000
local outbuf = ffi.new("char[?]", 2^20)
ffi.C.setvbuf(ffi.C.stdout, outbuf, 0, 2^20)
io.write(">ONE Homo sapiens alu\n"); fasta_repeat(alu, N*2)
io.write(">TWO IUB ambiguity codes\n"); fasta_random(iub, N*3)
io.write(">THREE Homo sapiens frequency\n"); fasta_random(homosapiens, N*5)
ffi.C.fflush(ffi.C.stdout)
