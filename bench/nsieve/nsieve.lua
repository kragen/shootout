-- The Great Computer Language Shootout
-- http://shootout.alioth.debian.org/
-- contributed by Isaac Gouy


function nsieve(m,isPrime)
   for i=2,m do
      isPrime[i] = true
   end
   count = 0

   for i=2,m do
      if flags[i] then
         for k=i+i, m, i do
            isPrime[k] = false
         end
         count = count + 1
      end
   end
   return count
end
 

n = tonumber(arg and arg[1]) or 1
if n < 2 then n = 2 end
flags = {}

m = (2^n)*10000 
print( string.format("Primes up to %8d %8d", m, nsieve(m,flags)) )

m = (2^(n-1))*10000
print( string.format("Primes up to %8d %8d", m, nsieve(m,flags)) )

m = (2^(n-2))*10000 
print( string.format("Primes up to %8d %8d", m, nsieve(m,flags)) )

-- vim: ts=4 ft=lua
