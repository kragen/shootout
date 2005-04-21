-- $Id: fannkuch.lua,v 1.3 2005-04-21 19:44:46 igouy-guest Exp $
-- http://shootout.alioth.debian.org/
-- implemented by: Isaac Gouy

function fannkuch(n)
   local perm, perm1, count, maxPerm = {}, {}, {}, {}
   local maxFlipsCount, m, r = 0, n-1, n

   for i=0,m do perm1[i] = i end   
   while true do
      while r ~= 1 do count[r-1] = r; r = r-1 end           
      if not (perm1[0] == 0 or perm1[m] == m) then
         for i=0,m do perm[i] = perm1[i] end
         local flipsCount, k = 0
         while true do        
            k = perm[0]                       
            if k == 0 then break end                                                               
            for i=0,(k+1)/2 - 1 do perm[i],perm[k-i] = perm[k-i],perm[i] end
            flipsCount = flipsCount + 1
         end

         if flipsCount > maxFlipsCount then
            maxFlipsCount = flipsCount
            for i=0,m do maxPerm[i] = perm1[i] end
         end
      end

      -- Use incremental change to generate another permutation
      while true do
         if r == n then return maxFlipsCount end
         local perm0, i, j = perm1[0], 0       
         while i < r do
            j = i + 1
            perm1[i] = perm1[j]
            i = j
         end
         perm1[r] = perm0  
               
         count[r] = count[r] - 1
         if count[r] > 0 then break end
         r = r + 1
      end
   end
end
 
n = tonumber(arg and arg[1]) or 1
io.write("Pfannkuchen(", n, ") = ", fannkuch(n), "\n")

-- vim: ts=4 ft=lua
