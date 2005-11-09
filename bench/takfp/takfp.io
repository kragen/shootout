/* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   Contributed by Ian Osgood */

tak := block(x,y,z,
    if (y >= x, z, tak( tak(x-1,y,z), tak(y-1,z,x), tak(z-1,x,y) ) )
)

n := args at(0) asNumber

tak(n*3, n*2, n) asString(0,1) println

