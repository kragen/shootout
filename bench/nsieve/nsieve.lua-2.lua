nsieve = function(m)
	local isPrime, count = {}, 0
	for i = 2, m do
		if isPrime[i] == nil then
			for k = i + i, m, i do
				isPrime[k] = false
			end
			count = count + 1
		end
	end
	return count
end

local n = tonumber(arg and arg[1]) or 1
if n < 2 then n = 2 end

local m = (2^n)*10000
io.write( string.format("Primes up to %8d %8d", m, nsieve(m)), "\n")

m = (2^(n-1))*10000
io.write( string.format("Primes up to %8d %8d", m, nsieve(m)), "\n")

m = (2^(n-2))*10000
io.write( string.format("Primes up to %8d %8d", m, nsieve(m)), "\n")