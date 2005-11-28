"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy"!

!ComputerLanguageShootout.Benchmarks class methodsFor: 'benchmarking'!

sumcol: argvString
   | sum |
   sum := 0.
   [OS.Stdin atEnd] whileFalse: [
      sum := sum + (OS.Stdin through: Character cr) asNumber].

   OS.Stdout nextPutAll: sum printString; cr! !
