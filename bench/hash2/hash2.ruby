#!/usr/bin/ruby
# -*- mode: ruby -*-
# $Id: hash2.ruby,v 1.1 2004-05-19 18:10:02 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

n = Integer(ARGV.shift || 1)

hash1 = {}
for i in 0 .. 9999
    hash1["foo_" << i.to_s] = i
end

hash2 = Hash.new(0)
n.times do
    for k in hash1.keys
	hash2[k] += hash1[k]
    end
end

printf "%d %d %d %d\n",
    hash1["foo_1"], hash1["foo_9999"], hash2["foo_1"], hash2["foo_9999"]
