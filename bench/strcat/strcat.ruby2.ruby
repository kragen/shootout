#!/usr/bin/ruby
# -*- mode: ruby -*-
# $Id: strcat.ruby2.ruby,v 1.1 2004-05-19 18:13:35 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

n = Integer(ARGV.shift || 1)

str = ''
for i in 1 .. n
    str += "hello\n"
end
puts str.length
