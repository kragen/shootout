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

nsieve2
   | n |
   n := CEnvironment argv first asNumber.
   (n < 2) ifTrue: [n := 2].
   self primeBenchmarkFor: n to: Stdout using: Array.
   ^'' ! !

!Shootout.Tests class methodsFor: 'benchmarks'!

primeBenchmarkFor: v to: output using: arrayClass
   v to: v - 2 by: -1 do:
      [:n| | m |
      m := (2 raisedTo: n) * 10000.
      output
         nextPutAll: 'Primes up to '; nextPutAll: (m asPaddedString: 8);
         nextPutAll: ((self nsieve: m using: arrayClass) asPaddedString: 9); cr] ! !

!Shootout.Tests class methodsFor: 'auxillaries'!

nsieve: n using: arrayClass 
   | count isPrime |
   count := 0.
   isPrime := arrayClass new: n withAll: true.
   2 to: n do:
      [:i | 
      (isPrime at: i) ifTrue: 
         [i + i to: n by: i do:
            [:k | isPrime at: k put: false].
         count := count + 1]].
   ^count ! !


!Core.Integer methodsFor: 'computer language shootout'!

asPaddedString: aWidth
   | s |
   s := WriteStream on: (String new: 10).
   self printOn: s paddedWith: $  to: aWidth base: 10.
   ^s contents ! !

