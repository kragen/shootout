-- The Computer Language Benchmarks Game
-- http://shootout.alioth.debian.org/
-- contributed by Wim Couwenberg
-- adapted from Lua entry #5 by Mike Pall
--
-- requires LGMP "A GMP package for Lua 5.1"
--
-- Speed is increased by
--   1) slightly optimized use of the gmp API in matrix operations and
--   2) occasionally dividing out common factors from matrix coefficients
--
-- 14 September 2008

local gmp, aux = {}, {}
require"c-gmp"(gmp, aux)

local add, sub, addmul = gmp.mpz_add, gmp.mpz_sub, gmp.mpz_addmul_ui
local mul, div, divx = gmp.mpz_mul_ui, gmp.mpz_fdiv_q, gmp.mpz_divexact
local init, get, gcd = gmp.mpz_init_set_d, gmp.mpz_get_d, gmp.mpz_gcd

local tmp

local function produce(n1, n2, d, k)
  add(n2, n2, tmp)
  mul(n2, k + 2, n2)
  addmul(n2, n1, k - 1)
  mul(n1, 2*k - 1, n1)
  add(n1, tmp, n1)
  mul(d, 2*k + 1, d)
end

local function extract(n1, n2, d, y)
  mul(d, 10*y, tmp)
  mul(n1, 10, n1)
  mul(n2, 10, n2)
  sub(n1, tmp, n1)
  sub(n2, tmp, n2)
end

local function reduce(n1, n2, d)
  gcd(n1, n2, tmp)
  gcd(d, tmp, tmp)
  divx(n1, tmp, n1)
  divx(n2, tmp, n2)
  divx(d, tmp, d)
end

local function digit(n1, n2, d)
  local y = get(div(n1, d, tmp))
  if y == get(div(n2, d, tmp)) then return y end
end

-- Generate successive digits of PI.
local function pidigits(N)
  local write = io.write
  local floor = math.floor

  local n1, n2, d = init(4), init(3), init(1)
  tmp = init(0)

  local k = 1
  local i = 0
  local r = 64

  while i < N do
    local y = digit(n1, n2, d)
    if y then
      write(y)
      extract(n1, n2, d, y)
      i = i + 1
      if i == r then reduce(n1, n2, d); r = floor(1.0625*r) end
      if i % 10 == 0 then write("\t:", i, "\n") end
    else
      produce(n1, n2, d, k)
      k = k + 1
    end
  end
  if i % 10 ~= 0 then write(string.rep(" ", 10 - N % 10), "\t:", N, "\n") end
end

local N = tonumber(arg and arg[1]) or 27
pidigits(N)
