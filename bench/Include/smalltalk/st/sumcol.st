"* The Computer Language Shootout
    http://shootout.alioth.debian.org/
    contributed by Isaac Gouy *"!
!Tests class methodsFor: 'benchmark scripts'!sumcol   | input sum |   input := self stdin.   sum := 0.   [input atEnd] whileFalse: [      sum := sum + (input upTo: Character cr) asNumber].
   self stdout print: sum; nl.   ^''! !


