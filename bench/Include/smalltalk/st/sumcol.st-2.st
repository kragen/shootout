"* The Computer Language Shootout
    http://shootout.alioth.debian.org/
    contributed by Isaac Gouy *"!
!Tests class methodsFor: 'benchmark scripts'!sumcol2   | s sum |   s := self stdinSpecial.   sum := 0.   [s atEnd] whileFalse: [      sum := sum + (s upTo: Character cr) asNumber].
   self stdout       nextPutAll: sum printString;      nextPut: Character lf.   ^''! !


