function fannkuch(n)
   local perm, perm1, count, maxPerm = {}, {}, {}, {}
   local maxFlipsCount, m, r, check = 0, n-1, n, 0

   for i=0,m do perm1[i] = i end   
   while true do
      if check < 30 then
         for i=0,m do io.write(perm1[i]+1) end; io.write("\n")
         check = check + 1;
      end

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
