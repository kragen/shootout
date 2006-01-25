"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy "

!Float methodsFor: 'printing'!

printStringRoundedTo: anInteger
   | n s |
   n := 0.5d * (10 raisedToInteger: anInteger negated).
   s := ((self sign < 0) ifTrue: [self - n] ifFalse: [self + n]) printString.
   ^s copyFrom: 1 to: (s indexOf: $.) + anInteger ! !


| n k sum a |
n := Smalltalk arguments first asInteger.

sum := 0.0.
0 to: n-1 do: [:k| sum := sum + ((2.0/3.0) raisedTo: k)].
(sum printStringRoundedTo: 9) display. Transcript tab; show: '(2/3)^k'; cr. 

sum := 0.0.
1 to: n do: [:k| sum := sum + (k raisedTo: -0.5)].
(sum printStringRoundedTo: 9) display. Transcript tab; show: 'k^-0.5'; cr.

sum := 0.0.
1 to: n do: [:k| sum := sum + (1.0/(k*(k+1.0)))].
(sum printStringRoundedTo: 9) display. Transcript tab; show: '1/k(k+1)'; cr.

sum := 0.0. 
1 to: n do: [:k| | s | s := k sin. sum := sum + (1.0/(k*k*k*s*s))].
(sum printStringRoundedTo: 9) display. Transcript tab; show: 'Flint Hills'; cr.

sum := 0.0.
1 to: n do: [:k| | c | c := k cos. sum := sum + (1.0/(k*k*k*c*c))].
(sum printStringRoundedTo: 9) display. Transcript tab; show: 'Cookson Hills'; cr.

sum := 0.0.
1 to: n do: [:k| sum := sum + (1.0/k)].
(sum printStringRoundedTo: 9) display. Transcript tab; show: 'Harmonic'; cr. 

sum := 0.0.
1 to: n do: [:k| sum := sum + (1.0/(k raisedTo: 2.0))].
(sum printStringRoundedTo: 9) display. Transcript tab; show: 'Riemann Zeta'; cr. 

a := -1.0.

k := 0. sum := 0.0.
1 to: n do: [:k| a := a negated. sum := sum + (a/k)].
(sum printStringRoundedTo: 9) display. Transcript tab; show: 'Alternating Harmonic'; cr.

k := 0. sum := 0.0.
1 to: n do: [:k| a := a negated. sum := sum + (a/(2*k - 1))].
(sum printStringRoundedTo: 9) display. Transcript tab; show: 'Gregory'; cr !
