"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy"!

!ComputerLanguageShootout.Benchmarks class methodsFor: 'benchmarking'!

ackermann: argvString
   | n |
   n := argvString asNumber.
   OS.Stdout 
      nextPutAll: 'Ack(3,', n printString, '): ', (3 ackermann: n) printString; cr! !


!Core.Integer methodsFor: 'computer language shootout'!

ackermann: anInteger
   ^self = 0
      ifTrue: [anInteger + 1]
      ifFalse: [
         anInteger = 0
            ifTrue: [self - 1 ackermann:  1]
            ifFalse: [self - 1 ackermann: (self ackermann: anInteger - 1)] ]! !
