"  The Great Computer Language Shootout
   contributed by Isaac Gouy

   To run: gst -Q fibo.st -a 32
"

!Integer methodsFor: 'shootout'!

fibonacci
   ^self < 2 
      ifTrue: [1] 
      ifFalse: [(self - 2) fibonacci + (self - 1) fibonacci] ! !


| n |
n := (Smalltalk arguments at: 1) asInteger.
Transcript show: n fibonacci displayString; cr !