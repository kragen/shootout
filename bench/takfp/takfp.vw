"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy"!

!ComputerLanguageShootout.Benchmarks class methodsFor: 'benchmarking'!

takfp: argvString
   | n answer |
   n := argvString asNumber.
   answer := (n * 3.0) takfp: (n * 2.0) z: (n * 1.0).
   OS.Stdout nextPutAll: ((answer asFixedPoint: 1) printString copyWithout: $s); cr! !
