"* The Computer Language Benchmarks Game
    http://shootout.alioth.debian.org/
    contributed by Isaac Gouy *"!
!Tests class methodsFor: 'benchmark scripts'!sumcol2   | input sum |   input := self stdinSpecial.   sum := 0.   [input atEnd] whileFalse: [      sum := sum + (input upTo: Character cr) asNumber].
   self stdout print: sum; nl.   ^''! !


