rem The Computer Language Shootout
rem http://shootout.alioth.debian.org/
rem contributed by Josh Goldfoot

function fannkuch(n as integer) as integer
   dim as integer perm(n), permp(n), count(n)
   dim as integer print30, m, r, j, i, k, temp, mostFlips, flips, perm0
   print30 = 0
   mostFlips = 0
   m = n - 1
   for i = 0 to m : permp(i) = i : next i
   r = n
   do
      if print30 < 30 then
         for i = 0 to m
            print str(permp(i) + 1);
         next i
         print
         print30 += 1
      end if
      while r <> 1
         count(r-1) = r
         r -= 1
      wend
      if not ((permp(0)=0) or (permp(m)=m)) then
         for i = 0 to m 
            perm(i) = permp(i)
         next i
         flips = 0
         k = perm(0)
         do
           i=1
	        j=k-1
           while i<j 
               temp = perm(i)
               perm(i) = perm(j)
               i += 1
               perm(j)= temp
               j -= 1
           wend
           flips += 1
           j=perm(k)
           perm(k)=k
           k=j
         loop until k = 0
         if flips > mostFlips then mostFlips = flips
      end if
      while 1
         if r = n then
            return mostFlips
         else
            perm0 = permp(0)
            i = 0
            while i < r 
               k = i + 1
               permp(i) = permp(k)
               i = k
            wend
            permp(r) = perm0
            count(r) -= 1
            if count(r) > 0 then exit while
            r += 1
         end if
      wend
   loop while 1
end function

dim as integer n, answer
n = val(command$)
if n < 1 then n = 7
answer = fannkuch(n)
print "Pfannkuchen(";str(n);") ="; answer

