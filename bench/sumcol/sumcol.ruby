#!/usr/bin/ruby
# -*- mode: ruby -*-
# $Id: sumcol.ruby,v 1.1 2004-05-19 18:13:44 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/
# from: Mathieu Bouchard

count = 0
while STDIN.gets()
    count += $_.to_i
end
puts count
