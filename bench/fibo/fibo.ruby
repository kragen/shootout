#!/usr/bin/ruby
# -*- mode: ruby -*-
# $Id: fibo.ruby,v 1.2 2005-03-19 00:32:56 igouy-guest Exp $
# http://www.bagley.org/~doug/shootout/

def fib(n)
    if n < 2 then
	   n
    else
	   fib(n-2) + fib(n-1)
    end
end

N = Integer(ARGV.shift || 1)
puts fib(N)
