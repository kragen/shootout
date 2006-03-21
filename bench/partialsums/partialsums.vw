"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy *"!

!LimitedPrecisionReal methodsFor: 'printing'!

printWithName: aString
   OS.Stdout nextPutAll: (self asStringWith: 9); 
      nextPut: Character tab; nextPutAll: aString; cr ! !

!Shootout.Tests class methodsFor: 'benchmarking'!

partialsums
   | n a1 a2 a3 a4 a5 a6 a7 a8 a9 twothirds alt |
   n := CEnvironment argv first asNumber asDouble.

   a1 := 0.0d. a2 := 0.0d. a3 := 0.0d. a4 := 0.0d. a5 := 0.0d.
   a6 := 0.0d. a7 := 0.0d. a8 := 0.0d. a9 := 0.0d.
   twothirds := 2.0d/3.0d.
   alt := -1.0d.

   1.0d to: n do: [:k| | k2 k3 sk ck |
      k2 := k*k.
      k3 := k2*k.
      sk := k sin.
      ck := k cos.
      alt := -1.0d * alt.

      a1 := a1 + (twothirds raisedTo: k - 1.0d).
      a2 := a2 + (k raisedTo: -0.5).
      a3 := a3 + (1.0d/(k*(k+1.0d))).
      a4 := a4 + (1.0d/(k3*sk*sk)).
      a5 := a5 + (1.0d/(k3*ck*ck)).
      a6 := a6 + (1.0d/k).
      a7 := a7 + (1.0d/k2).
      a8 := a8 + (alt/k).
      a9 := a9 + (alt/(2.0d*k - 1.0d)).
   ].

   a1 printWithName: '(2/3)^k'.
   a2 printWithName: 'k^-0.5'.
   a3 printWithName: '1/k(k+1)'.
   a4 printWithName: 'Flint Hills'.
   a5 printWithName: 'Cookson Hills'.
   a6 printWithName: 'Harmonic'.
   a7 printWithName: 'Riemann Zeta'.
   a8 printWithName: 'Alternating Harmonic'.
   a9 printWithName: 'Gregory'.
   ^'' ! !
