"* The Computer Language Benchmarks Game
    http://shootout.alioth.debian.org/
    contributed by Paolo Bonzini *"!
!Tests class methodsFor: 'benchmark scripts'!sumcol3   | s sum |
   s := self stdinSpecial.
   sum := 0.
   [s atEnd] whileFalse: [
      sum := sum + s nextLine asInteger].
   self stdout print: sum; nl.
   ^''! !

