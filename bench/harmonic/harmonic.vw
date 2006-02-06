"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy"!

!Shootout.Tests class methodsFor: 'benchmarking'!

harmonic
   | n partialSum |
   n := CEnvironment argv first asNumber.
   partialSum := 0.0d.
   1 to: n do: [:i| partialSum := partialSum + (1.0d/i)].
   ^((partialSum asFixedPoint: 9) printString copyWithout: $s) withNl ! !
