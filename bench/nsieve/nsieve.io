/* The Computer Language Shootout
   http://shootout.alioth.debian.org

   contributed by Ian Osgood */

Sequence pad := method(w, s:=self; while (s size < w, s=" ".. s) )

sieve := Object clone do(
    flags := Sequence clone
    show := method(n,
        flags setSize(n)
        for (i, 2, n-1, flags atPut(i, 1))  # true
        primes := 0
        for (i, 2, n-1,
            if (flags at(i) == 1,
                primes = primes + 1
                j := i + i
                while (j < n,
                    flags atPut(j, 0)
                    j = j + i
                )
            )
        )
        writeln("Primes up to", n asString pad(9), primes asString pad(9))  
    )
)

n := args at(0) asNumber
sieve show(10000 shiftLeft(n))
sieve show(10000 shiftLeft(n-1))
sieve show(10000 shiftLeft(n-2))
