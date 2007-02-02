"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Paolo Bonzini *"

!Float methodsFor: 'printing'!

printStringRoundedTo: anInteger
   | n s |
   n := 0.5d * (10 raisedToInteger: anInteger negated).
   s := ((self sign < 0) ifTrue: [self - n] ifFalse: [self + n]) printString.
   ^s copyFrom: 1 to: (s indexOf: $.) + anInteger !

printWithName: aString
   (self printStringRoundedTo: 9) display. Transcript tab; show: aString; cr ! !


| n a1 a2 a3 a4 a5 a6 a7 a8 a9 r2 r3 kf sk ck recip twothirds alt |

n := Smalltalk arguments first asInteger.

a1 := 0.0. a2 := 0.0. a3 := 0.0. a4 := 0.0. a5 := 0.0.
a6 := 0.0. a7 := 0.0. a8 := 0.0. a9 := 0.0.
twothirds := 2.0/3.0.
alt := -1.

1 to: n do: [:k|
   kf := k asFloat.
   sk := kf sin.
   ck := kf cos.
   alt := 0 - alt.
   recip := 1.0 / k.
   r2 := recip*recip.
   r3 := r2*recip.

   a1 := a1 + (twothirds raisedTo: k - 1).
   a2 := a2 + recip sqrt.

   "Work around a bug in the verifier"
   kf := (recip/(k+1.0)).   a3 := a3 + kf.

   a4 := a4 + (r3/(sk*sk)).
   a5 := a5 + (r3/(ck*ck)).
   a6 := a6 + recip.
   a7 := a7 + r2.
   a8 := a8 + (recip * alt).
   a9 := a9 + (1.0 /(2.0 * (k * alt) - alt)).
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
