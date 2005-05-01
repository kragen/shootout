# Takfp.awk
#
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Contributed by David Jones

function tak(x, y, z) {
  if(y >= x) {
    return z
  }
  return tak(tak(x-1.0,y,z),tak(y-1.0,z,x),tak(z-1.0,x,y))
}
BEGIN {
  n = ARGV[1]
  if(!n) { n = 1 }
  print tak(3.0*n, 2.0*n, 1.0*n)
}
