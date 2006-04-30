/* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   Contributed by Ian Osgood */

ack := block(i, j,
    if (i == 0, j+1,
    if (j == 0, ack(i-1, 1),
                ack(i-1, ack(i, j-1)) ) )
)

n := args at(1) asNumber
writeln("Ack(3,", n, "): ", ack(3,n))
