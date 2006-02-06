"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy"!

!Shootout.Tests class methodsFor: 'benchmarking'!

nsieve
   | n |
   n := CEnvironment argv first asNumber.
   (n < 2) ifTrue: [n := 2].
    n      primes.
   (n - 1) primes.
   (n - 2) primes.
   ^'' ! !


!Core.SmallInteger methodsFor: 'computer language shootout'!

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

   ^count ! !


!Core.SmallInteger methodsFor: 'computer language shootout'!

primes
   | m |
   m := (2 raisedTo: self) * 10000.
   OS.Stdout
      nextPutAll: 'Primes up to '; nextPutAll: (m asPaddedString: 8);
      nextPutAll: ((m nsieve) asPaddedString: 9); cr ! !


!Core.Integer methodsFor: 'computer language shootout'!

asPaddedString: aWidth
   | s |
   s := WriteStream on: (String new: 10).
   self printOn: s paddedWith: $  to: aWidth base: 10.
   ^s contents ! !
