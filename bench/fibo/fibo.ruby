#!/usr/bin/ruby
# -*- mode: ruby -*-
# $Id: fibo.ruby,v 1.1 2004-05-19 18:09:49 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

def fib(n)
    if n < 2 then
	1
    else
	fib(n-2) + fib(n-1)
    end
end

N = Integer(ARGV.shift || 1)
puts fib(N)
