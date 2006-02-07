"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy
   modified by Paolo Bonzini"!

!Shootout.Tests class methodsFor: 'benchmarking'!

nsievebits
   | n |
   n := CEnvironment argv first asNumber.
   (n < 2) ifTrue: [n := 2].
    n      primesBits.
   (n - 1) primesBits.
   (n - 2) primesBits.
   ^'' ! !


!Core.SmallInteger methodsFor: 'computer language shootout'!

nsieveBits
    | count isComposite |
    self < 2 ifTrue: [ ^0 ].

    isComposite := Shootout.BitArray new: self.
    count := 0.
    2 to: self do: [ :i |
	(isComposite at: i) ifFalse: [
	    count := count + 1.
	    i + i to: self by: i do: [ :k |
		isComposite at: k put: true ] ].
    ].
    ^count ! !


!Core.SmallInteger methodsFor: 'computer language shootout'!

primesBits
   | m |
   m := (2 raisedTo: self) * 10000.
   OS.Stdout
      nextPutAll: 'Primes up to '; nextPutAll: (m asPaddedString: 8);
      nextPutAll: ((m nsieveBits) asPaddedString: 9); cr ! !


!Core.SmallInteger methodsFor: 'computer language shootout'!

asPaddedString: aWidth
   | s |
   s := WriteStream on: (String new: 10).
   self printOn: s paddedWith: $  to: aWidth base: 10.
   ^s contents ! !


Smalltalk.Shootout defineClass: #BitArray
	superclass: #{Core.Object}
	indexedType: #bytes
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'Shootout'!


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
    ^bit ! !
