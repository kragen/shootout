"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy *"!

Smalltalk.Shootout defineClass: #Tests
   superclass: #{Core.Object}
   indexedType: #none
   private: false
   instanceVariableNames: ''
   classInstanceVariableNames: ''
   imports: ''
   category: 'ComputerLanguageShootout' !

!Shootout.Tests class methodsFor: 'benchmark scripts'!

fasta
   | n stdout r |
   n := CEnvironment argv first asNumber.
   stdout := ExternalWriteStream on: 
      (ExternalConnection ioAccessor: (UnixDiskFileAccessor new handle: 1)).

   stdout writeFasta: 'ONE Homo sapiens alu' sequence:
   ( RepeatStream to: n*2 on:
      'GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG',
      'GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA',
      'CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT',
      'ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA',
      'GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG',
      'AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC',
      'AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA' ).

   r := RandomNumber to: 1. "Shared random sequence"

   stdout writeFasta: 'TWO IUB ambiguity codes' sequence:
   (( RandomStream to: n*3 on: (
      OrderedCollection new
         add: (Association key: $a value: 0.27d);
         add: (Association key: $c value: 0.12d);
         add: (Association key: $g value: 0.12d);
         add: (Association key: $t value: 0.27d);

         add: (Association key: $B value: 0.02d);
         add: (Association key: $D value: 0.02d);
         add: (Association key: $H value: 0.02d);
         add: (Association key: $K value: 0.02d);
         add: (Association key: $M value: 0.02d);
         add: (Association key: $N value: 0.02d);
         add: (Association key: $R value: 0.02d);
         add: (Association key: $S value: 0.02d);
         add: (Association key: $V value: 0.02d);
         add: (Association key: $W value: 0.02d);
         add: (Association key: $Y value: 0.02d);
         yourself )) random: r).

   stdout writeFasta: 'THREE Homo sapiens frequency' sequence:
   (( RandomStream to: n*5 on: (
      OrderedCollection new
         add: (Association key: $a value: 0.3029549426680d);
         add: (Association key: $c value: 0.1979883004921d);
         add: (Association key: $g value: 0.1975473066391d);
         add: (Association key: $t value: 0.3015094502008d);
         yourself )) random: r).

   stdout flush.
   ^'' ! !


Smalltalk.Shootout defineClass: #RepeatStream
	superclass: #{Core.ReadStream}
	indexedType: #none
	private: false
	instanceVariableNames: 'repeatPtr repeatLimit'
	classInstanceVariableNames: ''
	imports: ''
	category: 'Shootout'!

!Shootout.RepeatStream class methodsFor: 'instance creation'!

to: anInteger on: aCollection 
   ^(super on: aCollection) to: anInteger ! !

!Shootout.RepeatStream methodsFor: 'initialize-release'!

to: anInteger
   repeatPtr := 0.
   repeatLimit := anInteger ! !

!Shootout.RepeatStream methodsFor: 'accessing'!

next
   position >= readLimit ifTrue: [ self position: 0 ].
   repeatPtr := repeatPtr + 1.
   ^collection at: (position := position + 1) ! !

!Shootout.RepeatStream methodsFor: 'testing'!

atEnd
   ^repeatPtr >= repeatLimit ! !


Smalltalk.Shootout defineClass: #RandomStream
	superclass: #{Shootout.RepeatStream}
	indexedType: #none
	private: false
	instanceVariableNames: 'random percentages'
	classInstanceVariableNames: ''
	imports: ''
	category: 'Shootout'!

!Shootout.RandomStream methodsFor: 'initialize-release'!

on: aCollection
   | size cp |
   repeatPtr := 0.
   random := RandomNumber to: 1.0.
   size := aCollection size.
   percentages := Array new: size.
   collection := Array new: size.
   cp := 0.0d.
   1 to: size do: [:i| 
      collection at: i put: (aCollection at: i) key.
      percentages at: i put: (cp := cp + (aCollection at: i) value).
   ] ! !

!Shootout.RandomStream methodsFor: 'accessing'!

next
   | r |
   r := random next.
   repeatPtr := repeatPtr + 1.
   1 to: percentages size do: [:i| 
      (r < (percentages at: i)) ifTrue: [^collection at: i]] ! 

random: aRandomNumber
"* Share the random number generator so we can get the expected results. *"
   random := aRandomNumber ! !


! ExternalWriteStream methodsFor: 'accessing'!

writeFasta: aString sequence: aStream
   | i |
   self nextPut: $>; nextPutAll: aString; cr.
   i := 0.
   [aStream atEnd] whileFalse: [
      (i == 60) ifTrue: [self cr. i := 0].
      self nextPut: aStream next.
      i := i + 1.
      ].
   self cr ! !


Smalltalk.Shootout defineClass: #RandomNumber
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'seed scale '
	classInstanceVariableNames: ''
	imports: ''
	category: 'Shootout'!

Shootout.RandomNumber defineSharedVariable: #Modulus
	private: false
	constant: false
	category: 'computer language shootout'
	initializer: '139968'!

#{Shootout.RandomNumber.Modulus} initialize!

Shootout.RandomNumber defineSharedVariable: #FModulus
	private: false
	constant: false
	category: 'computer language shootout'
	initializer: '139968.0d'!

#{Shootout.RandomNumber.FModulus} initialize!

Shootout.RandomNumber defineSharedVariable: #Multiplier
	private: false
	constant: false
	category: 'computer language shootout'
	initializer: '3877'!

#{Shootout.RandomNumber.Multiplier} initialize!

Shootout.RandomNumber defineSharedVariable: #Increment
	private: false
	constant: false
	category: 'computer language shootout'
	initializer: '29573'!

#{Shootout.RandomNumber.Increment} initialize!


!Shootout.RandomNumber class methodsFor: 'instance creation'!

to: anInteger
   ^self basicNew to: anInteger ! !


!Shootout.RandomNumber methodsFor: 'accessing'!

next
   seed := (seed * Multiplier + Increment) \\ Modulus.
   ^(seed * scale) asDouble / FModulus ! !

!Shootout.RandomNumber methodsFor: 'private'!

to: anInteger
   seed := 42.
   scale := anInteger ! !


