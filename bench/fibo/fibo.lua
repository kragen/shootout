-- $Id: fibo.lua,v 1.2 2005-03-19 00:32:56 igouy-guest Exp $
-- http://www.bagley.org/~doug/shootout/

function fib(n)
    if (n < 2) then return(n) end
    return( fib(n-2) + fib(n-1) )
end

N = tonumber((arg and arg[1])) or 1
io.write(fib(N), "\n")
