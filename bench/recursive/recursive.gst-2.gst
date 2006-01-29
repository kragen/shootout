"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy "

!SmallInteger methodsFor: 'shootout'!

ackermann: aSmallInteger
   ^self == 0
      ifTrue: [aSmallInteger + 1]
      ifFalse: [
         aSmallInteger == 0
            ifTrue: [self - 1 ackermann:  1]
            ifFalse: [self - 1 ackermann: (self ackermann: aSmallInteger - 1)] ] !

fibonacci
   ^self < 2 
      ifTrue: [1] 
      ifFalse: [(self - 2) fibonacci + (self - 1) fibonacci] ! 


tak: y z: z
   ^y < self 
      ifTrue: [ ((self - 1) tak: y z: z) 
           tak: ((y - 1) tak: z z: self) 
             z: ((z - 1) tak: self z: y)
         ]
      ifFalse: [z] ! !


!Float methodsFor: 'shootout'!

fibonacci
   ^self < 2.0
      ifTrue: [1.0] 
      ifFalse: [(self - 2.0) fibonacci + (self - 1.0) fibonacci] ! 


tak: y z: z
   ^y < self 
      ifTrue: [ ((self - 1.0) tak: y z: z) 
           tak: ((y - 1.0) tak: z z: self) 
             z: ((z - 1.0) tak: self z: y)
         ]
      ifFalse: [z] ! !


| n | 
n := Smalltalk arguments first asInteger.

Transcript show: 'Ack(3,'; show: n printString; show: '): '; 
   show: (3 ackermann: n) printString; nl.

Transcript show: 'Fib('. 
((27.0+n) asScaledDecimal: 1) display. Transcript show: '): '. 
((27.0+n) fibonacci asScaledDecimal: 1) displayNl.

n := n - 1.
Transcript show: 'Tak('; show: (3*n) printString; show: ','; 
   show: (2*n) printString; show: ','; show: n printString; show: '): '. 
((3*n tak: 2*n z: n) asScaledDecimal: 1) displayNl.

Transcript show: 'Fib(3): '; show: 3 fibonacci printString; nl.

Transcript show: 'Tak(3.0,2.0,1.0): '.
((3.0 tak: 2.0 z: 1.0) asScaledDecimal: 1) displayNl !
