"The Computer Language Shootout
 http://shootout.alioth.debian.org/
 contributed by Isaac Gouy"


ReadStream subclass: #RepeatStream
instanceVariableNames: '' classVariableNames: '' poolDictionaries: '' category: nil !

!RepeatStream methodsFor: 'accessing-reading'!

next
"Answer the next item of the receiver. When at end of stream go back to start."
    | element |
    (access bitAnd: 1) = 0
    	ifTrue: [ ^self shouldNotImplement ].
    ptr > endPtr ifTrue: [ self position: 0 ].
    element := collection at: ptr.
    ptr := ptr + 1.
    ^element ! !


Object subclass: #RandomNucleotideStream
instanceVariableNames: 'random percentages codes size'
classVariableNames: '' poolDictionaries: '' category: nil !

!RandomNucleotideStream methodsFor: 'initialize-release'!

from: anOrderedCollection
   | cp i |
   "random := RandomNumber to: 1.0."
   codes := ByteArray new: anOrderedCollection size.
   size := anOrderedCollection size * 8.
   percentages := ByteArray new: size.

   cp := 0.0. i := 0. 
   anOrderedCollection do: [:each | 
      percentages doubleAt: (i*8)+1 put: (cp := cp + each value).      
      codes byteAt: (i//8)+1 put: each key asInteger.
   ] ! !


!RandomNucleotideStream methodsFor: 'accessing'!

next
   | r |
   r := random next.
   1 to: size by: 8 do: [:i| 
      (r < (percentages doubleAt: i))
         ifTrue: [^codes byteAt: (i//8)+1] ] !

random: aRandomNumber
"This wierdness is just so we can get the expected results.
 Normally we'd initialize our own RandomNumber source instead
 of sharing one"
   random := aRandomNumber ! !


! FileStream methodsFor: 'accessing'!

writeFasta: anId description: aString size: anInteger sequence: aStream 
   | lineLength n |
   lineLength := 60. n := anInteger.
   self nextPut: $>; nextPutAll: anId; nextPutAll: ' '; nextPutAll: aString; nl.

   [n > 0] whileTrue: [
         ((n < lineLength) ifTrue: [n] ifFalse: [lineLength]) 
            timesRepeat: [self nextPutByte: aStream next].
         self nl.
         n := n - lineLength
      ] ! !


Object subclass: #RandomNumber
instanceVariableNames: 'seed scale'
classVariableNames: 'Increment Multiplier Modulus FModulus'
poolDictionaries: '' category: nil !

!RandomNumber class methodsFor: 'instance creation'!

to: anInteger
   Increment := 29573.
   Multiplier := 3877.
   Modulus := 139968.
   FModulus := 139968.0d. 
   ^self basicNew to: anInteger ! !
   
!RandomNumber methodsFor: 'accessing'!

next
   seed := seed * Multiplier + Increment \\ Modulus.
   ^(seed * scale) asFloatD / FModulus ! !
     
!RandomNumber methodsFor: 'private'!

to: anInteger
   seed := 42.
   scale := anInteger ! !


| n r s |
n := Smalltalk arguments first asInteger.
r := RandomNumber to: 1. "Shared random sequence"
s := FileStream stdout bufferSize: 4096.

s writeFasta: 'ONE' description: 'Homo sapiens alu' size: n*2 sequence: 
   ( RepeatStream on: 
      'GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG',
      'GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA',
      'CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT',
      'ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA',
      'GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG',
      'AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC',
      'AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA' asByteArray).

s writeFasta: 'TWO' description: 'IUB ambiguity codes' size: n*3 sequence: 
   ( RandomNucleotideStream new random: r; from: (
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
         yourself )).

s writeFasta: 'THREE' description: 'Homo sapiens frequency' size: n*5 sequence: 
   ( RandomNucleotideStream new random: r; from: (
      OrderedCollection new
         add: (Association key: $a value: 0.3029549426680);
         add: (Association key: $c value: 0.1979883004921);
         add: (Association key: $g value: 0.1975473066391);
         add: (Association key: $t value: 0.3015094502008);
         yourself )).

s flush; close !
