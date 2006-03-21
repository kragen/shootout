"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy *"

!Shootout.Tests class methodsFor: 'benchmarking'!

ackermann
   | n |
   n := CEnvironment argv first asNumber.
   ^'Ack(3,', n printString, '): ', (3 ackermann: n) printString withNl ! !


!Core.SmallInteger methodsFor: 'computer language shootout'!

ackermann: anInteger
   ^self = 0
      ifTrue: [anInteger + 1]
      ifFalse: [
         anInteger = 0
            ifTrue: [self - 1 ackermann:  1]
            ifFalse: [self - 1 ackermann: (self ackermann: anInteger - 1)] ] ! !
