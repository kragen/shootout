"* The Computer Language Shootout
 http://shootout.alioth.debian.org/
 contributed by Isaac Gouy 
 modified by Paolo Bonzini *"

ReadStream subclass: #RepeatStream  instanceVariableNames: 'repeatPtr repeatLimit' classVariableNames: '' poolDictionaries: '' category: nil !

!RepeatStream class methodsFor: 'instance creation '!

to: anInteger on: aCollection
   ^(super on: aCollection) to: anInteger ! !

!RepeatStream methodsFor: 'initialize-release'!

to: anInteger
   repeatPtr := 0.
   repeatLimit := anInteger ! !

!RepeatStream methodsFor: 'accessing-reading'!

next
    | element |
    ptr > endPtr ifTrue: [ self position: 0 ].
    element := collection at: ptr.
    ptr := ptr + 1. repeatPtr := repeatPtr + 1.
    ^element ! !

!RepeatStream methodsFor: 'testing'!

atEnd
   ^repeatPtr >= repeatLimit ! !


RepeatStream subclass: #RandomStream instanceVariableNames: 'random percentages'
classVariableNames: '' poolDictionaries: '' category: nil !

!RandomStream methodsFor: 'private methods'!

initCollection: aCollection limit: size
   | cp |
   repeatPtr := 0.
   random := RandomNumber to: 1.0.
   percentages := Array new: size.
   collection := Array new: size.
   cp := 0.0.
   1 to: size do: [:i|
      cp := cp + (aCollection at: i) value.
      collection at: i put: (aCollection at: i) key.
      percentages at: i put: (cp * RandomNumber scale) ceiling.
   ] ! !

!RandomStream methodsFor: 'accessing'!

next
   | r |
   r := random next.
   repeatPtr := repeatPtr + 1.
   1 to: percentages size do: [:i|
      (r < (percentages at: i)) ifTrue: [^collection at: i]].
self halt !

random: aRandomNumber
"* Share the random number generator so we can get the expected results. *"
   random := aRandomNumber ! !


! FileStream methodsFor: 'accessing'!

writeFasta: aString sequence: aStream
   | i |
   self nextPut: $>; nextPutAll: aString; nl.

   i := 0.
   [aStream atEnd] whileFalse: [
      (i == 60) ifTrue: [self nl. i := 0].
      self nextPut: aStream next.
      i := i + 1.
      ].
   self nl ! !


Object subclass: #RandomNumber
instanceVariableNames: 'seed scale'
classVariableNames: 'Increment Multiplier Modulus '
poolDictionaries: '' category: nil !

!RandomNumber class methodsFor: 'instance creation'!

scale
   ^Modulus!

to: anInteger
   Increment := 29573.
   Multiplier := 3877.
   Modulus := 139968.
   ^self basicNew to: anInteger ! !

!RandomNumber methodsFor: 'accessing'!

next
   ^seed := seed * Multiplier + Increment \\ Modulus! !

!RandomNumber methodsFor: 'private'!

to: anInteger
   seed := 42.
   scale := anInteger ! !


| n r s x |
n := Smalltalk arguments first asInteger.
s := FileStream stdout bufferSize: 4096.

s writeFasta: 'ONE Homo sapiens alu' sequence:
   ( RepeatStream to: n*2 on:
      'GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG',
      'GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA',
      'CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT',
      'ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA',
      'GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG',
      'AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC',
      'AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA' ).

r := RandomNumber to: 1. "Shared random sequence"

s writeFasta: 'TWO IUB ambiguity codes' sequence:
   (( RandomStream to: n*3 on: (
      OrderedCollection new
         add: (Association key: $a value: 0.27);
         add: (Association key: $c value: 0.12);
         add: (Association key: $g value: 0.12);
         add: (Association key: $t value: 0.27);

         add: (Association key: $B value: 0.02);
         add: (Association key: $D value: 0.02);
         add: (Association key: $H value: 0.02);
         add: (Association key: $K value: 0.02);
         add: (Association key: $M value: 0.02);
         add: (Association key: $N value: 0.02);
         add: (Association key: $R value: 0.02);
         add: (Association key: $S value: 0.02);
         add: (Association key: $V value: 0.02);
         add: (Association key: $W value: 0.02);
         add: (Association key: $Y value: 0.02);
         yourself )) random: r).

s writeFasta: 'THREE Homo sapiens frequency' sequence:
   (( RandomStream to: n*5 on: (
      OrderedCollection new
         add: (Association key: $a value: 0.3029549426680);
         add: (Association key: $c value: 0.1979883004921);
         add: (Association key: $g value: 0.1975473066391);
         add: (Association key: $t value: 0.3015094502008);
         yourself )) random: r).

s flush; close !
