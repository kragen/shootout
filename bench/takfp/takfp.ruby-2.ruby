# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Contributed by: Robbert Haarman

def tak x, y, z
	(y >= x) ? z :
		tak(tak(x - 1.0, y, z), tak(y - 1, z, x), tak(z - 1, x, y))
end

def tak_n n
	tak n * 3.0, n * 2.0, n * 1.0
end
