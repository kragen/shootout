"  The Great Computer Language Shootout
   contributed by Isaac Gouy
  
   To run: gst -QI /usr/share/gnu-smalltalk/gst.im ackermann.st -a 8
"

!Integer methodsFor: 'shootout'!

ackermann: anInteger
   ^self = 0
      ifTrue: [anInteger + 1]
      ifFalse: [
         anInteger = 0
            ifTrue: [self - 1 ackermann:  1]
            ifFalse: [self - 1 ackermann: (self ackermann: anInteger - 1)] ] ! !

| n |
n := Smalltalk arguments first asInteger.

Transcript show: 'Ack(3,'; show: n printString; show: '): '; 
           show: (3 ackermann: n) printString; nl!
