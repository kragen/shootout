"* The Computer Language Shootout
    http://shootout.alioth.debian.org/
    contributed by Isaac Gouy *"!
!Tests class methodsFor: 'benchmark scripts'!sumcol   | s sum |   s := self stdin.   sum := 0.   [s atEnd] whileFalse: [      sum := sum + (s upTo: Character cr) asNumber].
   self stdout       nextPutAll: sum printString;      nextPut: Character lf.   ^''! !


