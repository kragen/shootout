-- The Computer Language Shootout
-- http://shootout.alioth.debian.org/
-- contributed by Mike Pall

local n = tonumber(arg[1])
local function pr(fmt, x) io.write(string.format(fmt, x)) end

do local sum, twothirds = 0, 2/3; for k=0,n do sum = sum + twothirds^k end
pr("%.9f\t(2/3)^k\n", sum) end

do local sum = 0; for k=1,n do sum = sum + k^-0.5 end
pr("%.9f\tk^-0.5\n", sum) end

do local sum = 0; for k=1,n do sum = sum + 1/(k*(k+1)) end
pr("%.9f\t1/k(k+1)\n", sum) end

do local sin = math.sin
local sum = 0; for k=1,n do local sk = sin(k); sum = sum + 1/(k*k*k*sk*sk) end
pr("%.9f\tFlint Hills\n", sum) end

do local cos = math.cos
local sum = 0; for k=1,n do local ck = cos(k); sum = sum + 1/(k*k*k*ck*ck) end
pr("%.9f\tCookson Hills\n", sum) end

do local sum = 0; for k=1,n do sum = sum + 1/k end
pr("%.9f\tHarmonic\n", sum) end

do local sum = 0; for k=1,n do sum = sum + 1/(k*k) end
pr("%.9f\tRiemann Zeta\n", sum) end

do local sum = 0; for k=1,n-1,2 do sum = sum + 1/k end
for k=2,n,2 do sum = sum - 1/k end
pr("%.9f\tAlternating Harmonic\n", sum) end

do local sum = 0; for k=1,2*n-1,4 do sum = sum + 1/k end
for k=3,2*n,4 do sum = sum - 1/k end
pr("%.9f\tGregory\n", sum) end

