"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy"!

!Shootout.Tests class methodsFor: 'benchmarking'!

sumcol
   | sum |
   sum := 0.
   [OS.Stdin atEnd] whileFalse: [
      sum := sum + (OS.Stdin through: Character lf) asNumber].
   ^sum printString withNl ! !
