#!/usr/bin/ruby
# -*- mode: ruby -*-
# $Id: matrix.ruby,v 1.1 2004-05-19 18:10:34 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

n = Integer(ARGV.shift || 1)

size = 30

def mkmatrix(rows, cols)
    count = 1
    mx = Array.new(rows)
    for i in 0 .. (rows - 1)
	row = Array.new(cols, 0)
	for j in 0 .. (cols - 1)
	    row[j] = count
	    count += 1
	end
	mx[i] = row
    end
    mx
end

def mmult(rows, cols, m1, m2)
    m3 = Array.new(rows)
    for i in 0 .. (rows - 1)
	row = Array.new(cols, 0)
	for j in 0 .. (cols - 1)
	    val = 0
	    for k in 0 .. (cols - 1)
		val += m1.at(i).at(k) * m2.at(k).at(j)
	    end
	    row[j] = val
	end
	m3[i] = row
    end
    m3
end

m1 = mkmatrix(size, size)
m2 = mkmatrix(size, size)
mm = Array.new
n.times do
    mm = mmult(size, size, m1, m2)
end
puts "#{mm[0][0]} #{mm[2][3]} #{mm[3][2]} #{mm[4][4]}"
