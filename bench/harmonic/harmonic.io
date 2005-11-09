/* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   Contributed by Ian Osgood */

sum := 0
for (d,1,args at(0) asNumber, sum = sum + 1/d)
sum asString(0,9) println

