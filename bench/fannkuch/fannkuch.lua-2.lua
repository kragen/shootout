-- The Great Computer Language Shootout
-- http://shootout.alioth.debian.org/
-- contributed by Mike Pall

local function fannkuch(n)
  if n < 2 then return 0 end
  local maxflips, p, q, s = 0, {}, {}, {}
  for i=1,n do p[i] = i; s[i] = 1 end
  repeat
    local odd = false
    for x=2,n do
      local sx = s[x]
      if sx < x then
        s[x] = sx + 1
        if odd then p[x], p[1] = p[1], p[x] else p[x], p[sx] = p[sx], p[x] end
        local q1 = p[1]
        if p[n] ~= n and q1 ~= 1 then
          for i=2,n do q[i] = p[i] end
          for flips=1,1e6 do
            local j = q1 - 1
            for i=2,q1*0.5 do q[i], q[j] = q[j], q[i]; j = j - 1 end
            local qq = q[q1]
            if qq == 1 then
              if flips > maxflips then maxflips = flips end
              break
            end
            q[q1] = q1
            q1 = qq
          end
        end
        break
      end
      if x == n then return maxflips end
      s[x] = 1
      odd = not odd
    end
  until false
end

local n = tonumber(arg and arg[1]) or 1
io.write("Pfannkuchen(", n, ") = ", fannkuch(n), "\n")
