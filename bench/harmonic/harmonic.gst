"  The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Isaac Gouy
 
   To run: gst -QI /usr/local/share/smalltalk/gst.im harmonic.st -a 10000000
"

!Float methodsFor: 'printing'!

printStringRoundedTo: anInteger
   | n s |
   n := 0.5d * (10 raisedToInteger: anInteger negated).
   s := ((self sign < 0) ifTrue: [self - n] ifFalse: [self + n]) printString.
   ^s copyFrom: 1 to: (s indexOf: $.) + anInteger ! !


| n partialSum |
n := Smalltalk arguments first asInteger.
partialSum := 0.0.
1 to: n do: [:i| partialSum := partialSum + (1.0/i)].

(partialSum printStringRoundedTo: 9) displayNl !
