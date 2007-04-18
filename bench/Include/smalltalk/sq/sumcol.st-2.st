"* The Computer Language Shootout
    http://shootout.alioth.debian.org/
    contributed by Isaac Gouy *"!

!AttachableFileStream methodsFor: 'platform'!nextLine
   "* atEnd and atEndOfFile dont seem to find eof 
      for files redirected to stdin, but next does
      answer nil *"
   | ch |
   ^(ch := self next) isNil
      ifTrue: [nil]
      ifFalse: [(String with: ch), (self upTo: Character lf)]! !

!Tests class methodsFor: 'benchmark scripts'!sumcol2   | input sum |   input := self stdin.   sum := 0.0d0.   [(line := input nextLine) isNil] whileFalse: [  
      sum := sum + line asNumber.
   ].
   self stdout print: sum; nl.   ^''! !


