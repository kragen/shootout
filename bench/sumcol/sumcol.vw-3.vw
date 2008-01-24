"* The Computer Language Benchmarks Game
    http://shootout.alioth.debian.org/
    contributed by Carlo Teixeira *"!

!Tests class methodsFor: 'benchmark scripts'!
sumcol3
   | sum |
   sum := 0.
   self stdinSpecial linesDo: [:line | 
      sum := sum + (Integer readFrom: line readStream radix: 10) ].
   self stdout print: sum; nl.
   ^''! !


