"  The Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Isaac Gouy
   modified by Paolo Bonzini
"

Object
    variableByteSubclass: #BitArray
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: nil !

!BitArray class methodsFor: 'instance creation'!

new: size
    ^super new: (size + 7 bitShift: -3)! !

!BitArray methodsFor: 'accessing'!

at: index
    | wordIndex bitMask |
    wordIndex := ((index - 1) bitShift: -3) + 1.
    bitMask := 1 bitShift: (index - 1 bitAnd: 7).
    ^((self basicAt: wordIndex) bitAnd: bitMask) > 0!

at: index put: bit
    | wordIndex bitMask word |
    wordIndex := ((index - 1) bitShift: -3) + 1.
    bitMask := 1 bitShift: (index - 1 bitAnd: 7).

    word := self basicAt: wordIndex.
    word := word bitOr: bitMask.
    bit ifFalse: [word := word - bitMask].
    self basicAt: wordIndex put: word.
    ^bit! !

!Integer methodsFor: 'shootout'!

nsieve
    | count isComposite |
    self < 2 ifTrue: [ ^0 ].

    isComposite := BitArray new: self.
    count := 0.
    2 to: self do: [ :i |
	(isComposite at: i) ifFalse: [
	    count := count + 1.
	    i + i to: self by: i do: [ :k |
		isComposite at: k put: true ] ].
    ].
    ^count!


asPaddedString: anInteger
    | s |
    s := self printString.
    ^(String new: (anInteger - s size) withAll: $ ), s !


primes
    | m |
    m := (2 raisedTo: self) * 10000.
    Transcript
	show: 'Primes up to '; show: (m asPaddedString: 8);
	show: (m nsieve asPaddedString: 9); nl ! !


| n |
n := Smalltalk arguments first asInteger.
(n < 2) ifTrue: [n := 2].

 n      primes.
(n - 1) primes.
(n - 2) primes !
