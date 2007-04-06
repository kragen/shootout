"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy
   modified by Eliot Miranda *"!


Smalltalk.Shootout defineClass: #Tests
   superclass: #{Core.Object}
   indexedType: #none
   private: false
   instanceVariableNames: ''
   classInstanceVariableNames: ''
   imports: ''
   category: 'ComputerLanguageShootout' !

!Shootout.Tests class methodsFor: 'benchmark scripts'!

partialsums2
   self partialsums: CEnvironment argv first asNumber asDouble to: Stdout.
   ^'' ! !

!Shootout.Tests class methodsFor: 'benchmarks'!

partialsums: n to: output
   | a1 a2 a3 a4 a5 a6 a7 a8 a9 twothirds alt |

   a1 := a2 := a3 := a4 := a5 := a6 := a7 := a8 := a9 := 0.0d.
   twothirds := 2.0d/3.0d.
   alt := -1.0d.

   1.0d to: n do: [:k| | k2 k3 sk ck |
      k2 := k*k.
      k3 := k2*k.
      sk := k sin.
      ck := k cos.
      alt := -1.0d * alt.

      a1 := a1 + (twothirds raisedTo: k - 1.0d).
      a2 := a2 + (k raisedTo: -0.5d).
      a3 := a3 + (1.0d/(k*(k+1.0d))).
      a4 := a4 + (1.0d/(k3*sk*sk)).
      a5 := a5 + (1.0d/(k3*ck*ck)).
      a6 := a6 + (1.0d/k).
      a7 := a7 + (1.0d/k2).
      a8 := a8 + (alt/k).
      a9 := a9 + (alt/(2.0d*k - 1.0d))].

   a1 printOn: output withName: '(2/3)^k'.
   a2 printOn: output withName: 'k^-0.5'.
   a3 printOn: output withName: '1/k(k+1)'.
   a4 printOn: output withName: 'Flint Hills'.
   a5 printOn: output withName: 'Cookson Hills'.
   a6 printOn: output withName: 'Harmonic'.
   a7 printOn: output withName: 'Riemann Zeta'.
   a8 printOn: output withName: 'Alternating Harmonic'.
   a9 printOn: output withName: 'Gregory'.
   ^'' ! !


!Core.LimitedPrecisionReal methodsFor: 'printing'!

printOn: aStream withName: aString
   aStream  nextPutAll: (self asStringWith: 9); 
      nextPut: Character tab; nextPutAll: aString; cr. ! !


!Core.LimitedPrecisionReal methodsFor: 'converting'!

asStringWith: anInteger
   ^(self asFixedPoint: anInteger) printString copyWithout: $s ! !



