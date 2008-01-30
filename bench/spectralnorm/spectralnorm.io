/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org
   contributed by Ian Osgood */

A := block(i,j, 1/(((i+j)*(i+j+1)/2) + i+1))

Au := block(u, v,
    for(i, 0, u size - 1,
        t := 0
        u foreach(j, uj, t = t + A(i,j) * uj)
        v atPut(i, t)
    )
)

Atu := block(u, v,
    for(i, 0, u size - 1,
        t := 0
        u foreach(j, uj, t = t + A(j,i) * uj)
        v atPut(i, t)
    )
)

AtAu := block(u, v, w, Au(u,w); Atu(w,v) )

spectralNorm := block(n,
    u := List clone preallocateToSize(n)
    v := List clone preallocateToSize(n)
    w := List clone preallocateToSize(n)
    n repeatTimes( u push(1); v push(0); w push(0) )

    10 repeatTimes( AtAu(u,v,w); AtAu(v,u,w) )

    vBv := vv := 0
    v foreach(i, vi,
        vBv = vBv + vi * u at(i)
        vv  = vv  + vi squared
    )
    (vBv / vv) sqrt
)

spectralNorm(System args at(1) asNumber) asString(0,9) println

