/* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   Contributed by Ian Osgood */

Rand := Object clone do(
    IA := 3877
    IC := 29573
    IM := 139968
    last := 42
    gen_random := method(max,
        max * (last = ((last * IA + IC) % IM)) / IM
    )
)

(args at(0) asNumber - 1) repeatTimes( Rand gen_random(100) )

Rand gen_random(100) asString(0,9) println

