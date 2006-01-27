"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy "

!Float methodsFor: 'printing'!

printStringRoundedTo: anInteger
   | n s |
   n := 0.5d * (10 raisedToInteger: anInteger negated).
   s := ((self sign < 0) ifTrue: [self - n] ifFalse: [self + n]) printString.
   ^s copyFrom: 1 to: (s indexOf: $.) + anInteger !

printWithName: aString
   (self printStringRoundedTo: 9) display. Transcript tab; show: aString; cr ! !


| n a1 a2 a3 a4 a5 a6 a7 a8 a9 twothirds alt |

n := Smalltalk arguments first asInteger asFloat.


a1 := 0.0. a2 := 0.0. a3 := 0.0. a4 := 0.0. a5 := 0.0. 
a6 := 0.0. a7 := 0.0. a8 := 0.0. a9 := 0.0.
twothirds := 2.0/3.0.
alt := -1.0.

"a 'dirty' block - it uses variables captured from the environment"

1.0 to: n do: [:k| | k2 k3 sk ck |
   k2 := k*k.
   k3 := k2*k.
   sk := k sin.
   ck := k cos.
   alt := alt negated.

   a1 := a1 + ((2.0/3.0) raisedTo: k - 1.0).
   a2 := a2 + (k raisedTo: -0.5).
   a3 := a3 + (1.0/(k*(k+1.0))).
   a4 := a4 + (1.0/(k3*sk*sk)).
   a5 := a5 + (1.0/(k3*ck*ck)).
   a6 := a6 + (1.0/k).
   a7 := a7 + (1.0/k2).
   a8 := a8 + (alt/k).
   a9 := a9 + (alt/(2.0*k - 1.0)).
].

a1 printWithName: '(2/3)^k'.
a2 printWithName: 'k^-0.5'.
a3 printWithName: '1/k(k+1)'.
a4 printWithName: 'Flint Hills'.
a5 printWithName: 'Cookson Hills'.
a6 printWithName: 'Harmonic'. 
a7 printWithName: 'Riemann Zeta'.
a8 printWithName: 'Alternating Harmonic'.
a9 printWithName: 'Gregory' !
