"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy "

!Integer methodsFor: 'shootout'!

ackermann: anInteger
   ^self = 0
      ifTrue: [anInteger + 1]
      ifFalse: [
         anInteger = 0
            ifTrue: [self - 1 ackermann:  1]
            ifFalse: [self - 1 ackermann: (self ackermann: anInteger - 1)] ] ! !


!Number methodsFor: 'shootout'!

fibonacci
   ^self < 2 
      ifTrue: [self unity] 
      ifFalse: [(self - 2) fibonacci + (self - 1) fibonacci] ! 


tak: y z: z
   ^y < self 
      ifTrue: [ ((self - 1) tak: y z: z) 
           tak: ((y - 1) tak: z z: self) 
             z: ((z - 1) tak: self z: y)
         ]
      ifFalse: [z] ! !


| n m | 
n := Smalltalk arguments first asInteger.

Transcript show: 'Ack(3,'; show: n printString; show: '): '; 
   show: (3 ackermann: n) printString; nl.

m := n+15. 
Transcript show: 'Fib('; show: m printString; show: '): '; 
   show: m fibonacci printString; nl.

m := n+25.
Transcript show: 'Fib('; show: m printString; show: '): '. 
((m*1.0d0) fibonacci asScaledDecimal: 1) displayNl.

m := n-2. 
Transcript show: 'Tak('; show: (m*3) printString; show: ','; 
   show: (m*2) printString; show: ','; show: m printString; show: '): '; 
   show: ((m*3) tak: m*2 z: m) printString; nl.

Transcript show: 'Tak('; show: (m*3) printString; show: ','; 
   show: (m*2) printString; show: ','; show: m printString; show: '): '. 
(((m*3.0d0) tak: m*2.0d0 z: m*1.0d0) asScaledDecimal: 1) displayNl !


