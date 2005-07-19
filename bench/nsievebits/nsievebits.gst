"  The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Isaac Gouy

   To run: gst -QI /usr/local/share/smalltalk/gst.im nsievebits.st -a 7
"


Object subclass: #BitArray
instanceVariableNames: 'bits'
classVariableNames: ''
poolDictionaries: ''
category: nil !

!BitArray class methodsFor: 'instance creation'!

new: size
   ^super new withSize: size !
   
!BitArray methodsFor: 'initialize-release'!

withSize: size   
   bits := Array new: (size - 1 // 30) + 1 withAll: 0 !

!BitArray methodsFor: 'accessing'!

at: index
   | wordIndex bitIndex | 
   wordIndex := ((index - 1) // 30) + 1.
   bitIndex := (30 - index)  \\ 30.
   ^((bits at: wordIndex) bitShift: bitIndex negated) bitAnd: 1 !

at: index put: bit
   | wordIndex bitIndex word | 
   wordIndex := ((index - 1) // 30) + 1.
   bitIndex := (30 - index) \\ 30.
   word := bits at: wordIndex.
   
	word := 
	   bit = 1 
	      ifTrue: [word bitOr: (1 bitShift: bitIndex)]
	      ifFalse: [word bitAnd: (1 bitShift: bitIndex) bitInvert].   
 
   bits at: wordIndex put: word ! !


!Integer methodsFor: 'shootout'!

nsieve
   | count isPrime |
   count := 0.
   isPrime := BitArray new: self.
   
   2 to: self do: [:i|
      (isPrime at: i) == 0 ifTrue: [
         i+i to: self by: i do: [:k| isPrime at: k put: 1].
         count := count + 1.
         ].
      ].

   ^count ! 


asPaddedString: anInteger
   | s |
   s := self printString.
   ^(String new: (anInteger - s size) withAll: $ ), s !
   
   
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
