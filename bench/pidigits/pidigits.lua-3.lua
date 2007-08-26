-- The Computer Language Benchmarks Game
-- http://shootout.alioth.debian.org/
-- contributed by Pilho Kim

-- requires LGMP "A GMP package for Lua 5.1"
-- http://members.chello.nl/~w.couwenberg/lgmp.htm


require 'gmp'

-- Transformation

local T = {}

function T.bigzero() return gmp.z(0) end
function T.bigone() return gmp,z(1) end
function T.bigten() return gmp.z(10) end

function T.new(q1,r1,s1,t1)
   return {
       q = q1
      ,r = r1
      ,s = s1
      ,t = t1
      ,k = gmp.z(0)
      }
end

function T.newInt(q,r,s,t)
   return {
       q = gmp.z(q)
      ,r = gmp.z(r)
      ,s = gmp.z(s)
      ,t = gmp.z(t)
      ,k = gmp.z(0)
      }
end

function T.unity() return T.newInt(1, 0, 0, 1) end
function T.zero() return T.newInt(0, 0, 0, 0) end

function T.compose(a,b)
   local qq, qrrt, sqts, srtt
   qq = a.q * b.q
   qrrt = a.q * b.r + a.r * b.t
   sqts = T.bigzero()
   srtt = a.t * b.t
   return T.new(qq, qrrt, sqts, srtt)
end


function T.extract(a,j)
   local bigj = gmp.z(j)
   local qjr, sjt
   qjr = a.q * bigj + a.r
   sjt = a.t
   return qjr / sjt
end

function T.next(a)
   a.k = a.k + 1
   a.q = a.k
   a.t = 2*a.k + 1
   a.r = 2*a.t
   return a
end


-- Pi Digit Stream

local P = {}

function P.new()
   return {
       z = T.unity()
       ,x = T.zero()
      ,inverse = T.newInt(10, 0, 0, 1)
      }
end

function P.produce(a,j)
   local i = a.inverse
   i.r = T.bigzero() - T.bigten()*j
   return T.compose(i,a.z)
end

function P.consume(a,b)
   return T.compose(a.z,b)
end

function P.digit(a)
   return T.extract(a.z,3)
end

function P.isSafe(a,j)
   return j == T.extract(a.z,4)
end

function P.next(a)
   local y
   y = P.digit(a)
   if P.isSafe(a,y) then
      a.z = P.produce(a,y)
      return tostring(y)
   else
      a.z = P.consume(a,T.next(a.x))
      return P.next(a)
   end
end


-- Main
n = tonumber(arg and arg[1]) or 27

i = 0
length = 10
pidigit = P.new()

while n > 0 do
   if n < length then
      for _ = 1,n do io.write( P.next(pidigit) ) end
      for _ = 1,length - n do io.write( ' ' ) end
      i = i + n
   else
      for _ = 1,length do io.write( P.next(pidigit) ) end
      i = i + length
   end
   io.write('\t:', i, '\n')
   n = n - length
end

-- eof

