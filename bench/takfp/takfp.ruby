#  The Great Computer Language Shootout
#  http://shootout.alioth.debian.org/
#
#  contributed by Gabriele Renzi

def tak x, y, z
  return z unless y < x
  tak( tak(x-1.0, y, z),
    tak(y-1.0, z, x),
    tak(z-1.0, x, y))
  
end

n=Float(ARGV[0])
puts tak(n*3.0, n*2.0, n*1.0)

