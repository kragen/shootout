"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy *"

!Float methodsFor: 'printing'!

printStringRoundedTo: anInteger
   | n s |
   n := 0.5d * (10 raisedToInteger: anInteger negated).
   s := ((self sign < 0) ifTrue: [self - n] ifFalse: [self + n]) printString.
   ^s copyFrom: 1 to: (s indexOf: $.) + anInteger !

printWithName: aString
   (self printStringRoundedTo: 9) display. Transcript tab; show: aString; cr ! !


| n sum a |
n := Smalltalk arguments first asInteger asFloat.

sum := 0.0.
0.0 to: n - 1.0 do: [:k| sum := sum + ((2.0/3.0) raisedTo: k)].
sum printWithName: '(2/3)^k'.

sum := 0.0.
1.0 to: n do: [:k| sum := sum + (k raisedTo: -0.5)].
sum printWithName: 'k^-0.5'.

sum := 0.0.
1.0 to: n do: [:k| sum := sum + (1.0/(k*(k+1.0)))].
sum printWithName: '1/k(k+1)'.

sum := 0.0. 
1.0 to: n do: [:k| | s | s := k sin. sum := sum + (1.0/(k*k*k*s*s))].
sum printWithName: 'Flint Hills'.

sum := 0.0.
1.0 to: n do: [:k| | c | c := k cos. sum := sum + (1.0/(k*k*k*c*c))].
sum printWithName: 'Cookson Hills'.

sum := 0.0.
1.0 to: n do: [:k| sum := sum + (1.0/k)].
sum printWithName: 'Harmonic'. 

sum := 0.0.
1.0 to: n do: [:k| sum := sum + (1.0/(k raisedTo: 2.0))].
sum printWithName: 'Riemann Zeta'.

a := -1.0.

sum := 0.0.
1.0 to: n do: [:k| a := -1.0 * a. sum := sum + (a/k)].
sum printWithName: 'Alternating Harmonic'.

sum := 0.0.
1.0 to: n do: [:k| a := -1.0 * a. sum := sum + (a/(2.0*k - 1.0))].
sum printWithName: 'Gregory' !
