# The Computer Language Benchmarks Game
# http://shootout.alioth.debian.org/
# Contributed by Sokolov Yura
# Modified by Ryan Williams
# Modified by Isaac Gouy
# Modified by Artem Vorozhtsov

def fannkuch(n)
   maxFlips, m, r, check = 0, n-1, n, 0
   count = (1..n).to_a
   perm = (1..n).to_a

   while true
      if check < 30
         puts "#{perm.join}"
         check += 1
      end

      while r != 1
         count[r-1] = r
         r -= 1
      end

      if perm[0] != 1 and perm[m] != n
         perml = perm.clone #.dup
         flips = 0
         while (k = perml.first ) != 1
            i = 0; j = k - 1
            while i < j
              t = perml[i]; perml[i] = perml[j]; perml[j] = t
              i += 1; j -= 1
            end
            flips += 1
         end
         maxFlips = flips if flips > maxFlips
      end
      while true
         return maxFlips if r == n
         perm.insert r,perm.shift
         break if (count[r] -= 1) > 0
         r += 1
      end
   end
end

N = (ARGV[0] || 1).to_i
puts "Pfannkuchen(#{N}) = #{fannkuch(N)}"