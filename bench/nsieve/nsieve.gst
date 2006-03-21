"*  The Great Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy
   modified by Ian Osgood *"

!SmallInteger methodsFor: 'shootout'!

nsieve 
   | count isPrime |
   count := 0.
   isPrime := Array new: self withAll: true.

   2 to: self do: [:i|
      (isPrime at: i) ifTrue: [
         i+i to: self by: i do: [:k| isPrime at: k put: false].
         count := count + 1.
         ].
      ].

   ^count !

asPaddedString: width
   | s |
   s := self printString.
   ^(String new: (width - s size) withAll: $ ), s !

primes
   | m |
   m := (2 raisedTo: self) * 10000.
   Transcript
      show: 'Primes up to '; show: (m asPaddedString: 8);
      show: ((m nsieve) asPaddedString: 9); nl ! !


| n |
n := Smalltalk arguments first asInteger.
(n < 2) ifTrue: [n := 2].

 n      primes.
(n - 1) primes.
(n - 2) primes !

