"* The Computer Language Shootout
    http://shootout.alioth.debian.org/
    contributed by Isaac Gouy
    modified by Eliot Miranda *"!

!Tests class methodsFor: 'benchmarking'!partialsums: n to: output   | a1 a2 a3 a4 a5 a6 a7 a8 a9 twothirds alt |   a1 := a2 := a3 := a4 := a5 := a6 := a7 := a8 := a9 := 0.0d0.   twothirds := 2.0d0/3.0d0.   alt := -1.0d0.   1.0d0 to: n do: [:k| | k2 k3 sk ck |      k2 := k*k.      k3 := k2*k.      sk := k sin.      ck := k cos.      alt := -1.0d0 * alt.      a1 := a1 + (twothirds raisedTo: k - 1.0d0).      a2 := a2 + (k raisedTo: -0.5d0).      a3 := a3 + (1.0d0/(k*(k+1.0d0))).      a4 := a4 + (1.0d0/(k3*sk*sk)).      a5 := a5 + (1.0d0/(k3*ck*ck)).      a6 := a6 + (1.0d0/k).      a7 := a7 + (1.0d0/k2).      a8 := a8 + (alt/k).      a9 := a9 + (alt/(2.0d0*k - 1.0d0))].

   self print: a1 withName: '(2/3)^k' to: output.
   self print: a2 withName: 'k^-0.5' to: output.
   self print: a3 withName: '1/k(k+1)' to: output.
   self print: a4 withName: 'Flint Hills' to: output.
   self print: a5 withName: 'Cookson Hills' to: output.
   self print: a6 withName: 'Harmonic' to: output.
   self print: a7 withName: 'Riemann Zeta' to: output.
   self print: a8 withName: 'Alternating Harmonic' to: output.
   self print: a9 withName: 'Gregory' to: output.   ^''! !

!Tests class methodsFor: 'benchmarking'!
print: number withName: name to: output
   output print: number digits: 9; tab; nextPutAll: name; nl! !

!Tests class methodsFor: 'benchmark scripts'!partialsums   self partialsums: self arg asFloatD to: self stdout.   ^''! !

Tests partialsums!
