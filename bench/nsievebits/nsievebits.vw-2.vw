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

nsievebits2
   | n |
   n := CEnvironment argv first asNumber.
   (n < 2) ifTrue: [n := 2].
   self primeBenchmarkFor: n to: Stdout using: BitArray.
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


Smalltalk.Shootout defineClass: #BitArray
   superclass: #{Core.ArrayedCollection}
   indexedType: #bytes
   private: false
   instanceVariableNames: ''
   classInstanceVariableNames: ''
   imports: ''
   category: 'ComputerLanguageShootout' !

!Shootout.BitArray class methodsFor: 'instance creation'!

new: size
    ^super new: (size + 7 bitShift: -3) ! !

!Shootout.BitArray methodsFor: 'accessing'!

at: index
    | wordIndex bitMask |
    wordIndex := ((index - 1) bitShift: -3) + 1.
    bitMask := 1 bitShift: (index - 1 bitAnd: 7).
    ^((self basicAt: wordIndex) bitAnd: bitMask) > 0 ! 

at: index put: bit
    | wordIndex bitMask word |
    wordIndex := ((index - 1) bitShift: -3) + 1.
    bitMask := 1 bitShift: (index - 1 bitAnd: 7).

    word := self basicAt: wordIndex.
    word := word bitOr: bitMask.
    bit ifFalse: [word := word - bitMask].
    self basicAt: wordIndex put: word.
    ^bit !

atAllPut: anObject 
   "Put anObject at every one of the receiver's indices."

   | value |
   value := anObject ifTrue: [255] ifFalse: [0].
   1 to: self basicSize do: [:index | self basicAt: index put: value] ! !


!Core.Integer methodsFor: 'computer language shootout'!

asPaddedString: aWidth
   | s |
   s := WriteStream on: (String new: 10).
   self printOn: s paddedWith: $  to: aWidth base: 10.
   ^s contents ! !

