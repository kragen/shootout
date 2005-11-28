"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy"!

!ComputerLanguageShootout.Benchmarks class methodsFor: 'benchmarking'!

harmonic: argvString
   | n partialSum |
   n := argvString asNumber.
   partialSum := 0.0d.
   1 to: n do: [:i| partialSum := partialSum + (1.0d/i)].
   OS.Stdout nextPutAll: ((partialSum asFixedPoint: 9) printString copyWithout: $s); cr! !
