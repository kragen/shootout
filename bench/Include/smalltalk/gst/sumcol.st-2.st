"* The Computer Language Shootout
    http://shootout.alioth.debian.org/
    contributed by Isaac Gouy *"!
!Tests class methodsFor: 'benchmark scripts'!sumcol2   | s sum |   s := self stdinSpecial.   sum := 0.   [s atEnd] whileFalse: [      sum := sum + (s upTo: Character lf) asNumber].
   self stdout print: sum; nl.   ^''! !

