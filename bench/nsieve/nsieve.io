/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org
   contributed by Ian Osgood */

Sequence pad := method(w, s:=self; while (s size < w, s=" ".. s) )

sieve := Object clone do(
    flags := List clone
    show := method(n,
        flags empty preallocateToSize(n)
        n repeat(flags append(Object))  # true
        primes := 0
        for (i, 2, n-1,
            if (flags at(i),
                primes = primes + 1
                if (i+i < n, for (j, i+i, n-1, i, flags atPut(j, Nil) ) )
            )
        )
        writeln("Primes up to", n asString pad(9), primes asString pad(9))
    )
)

n := System args at(1) asNumber
sieve show(10000 shiftLeft(n))
sieve show(10000 shiftLeft(n-1))
sieve show(10000 shiftLeft(n-2))

