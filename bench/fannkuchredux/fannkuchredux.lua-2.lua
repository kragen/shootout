-- The Computer Language Benchmarks Game
-- http://shootout.alioth.debian.org/
-- contributed by Mike Pall

local ffi = require("ffi")

local function fannkuch(n)
  local tp, copy = ffi.typeof("uint8_t[?]"), ffi.copy
  local p, q, s, sign, maxflips, sum = tp(n), tp(n), tp(n), 1, 0, 0
  for i=0,n-1 do p[i] = i; q[i] = i; s[i] = i end
  repeat
    -- Copy and flip.
    local q1 = p[0]
    if q1 ~= 0 then
      local flips = 1
      copy(q, p, n)				-- Work on a copy.
      repeat
	local qq = q[q1]
	if qq == 0 then				-- ... until 1st element is 0.
	  sum = sum + sign*flips
	  if flips > maxflips then maxflips = flips end -- New maximum?
	  break
	end
	q[q1] = q1
	if q1 > 2 then
	  local i, j = 1, q1-1
	  repeat q[i], q[j] = q[j], q[i]; i = i + 1; j = j - 1; until i >= j
	end
	q1 = qq; flips = flips + 1
      until false
    end
    -- Permute.
    if sign == 1 then
      p[1], p[0] = p[0], p[1]; sign = -1	-- Rotate 0<-1.
    else
      p[1], p[2] = p[2], p[1]; sign = 1		-- Rotate 0<-1 and 0<-1<-2.
      for i=2,n-1 do
	local sx = s[i]
	if sx ~= 0 then s[i] = sx-1; break end
	if i == n-1 then return sum, maxflips end -- Out of permutations.
	s[i] = i
	-- Rotate 0<-...<-i+1.
	local t = p[0]; for j=0,i do p[j] = p[j+1] end; p[i+1] = t
      end
    end
  until false
end

local n = tonumber(arg and arg[1]) or 1
local sum, flips = fannkuch(n)
io.write(sum, "\nPfannkuchen(", n, ") = ", flips, "\n")
