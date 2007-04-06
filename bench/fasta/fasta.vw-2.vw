"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Eliot Miranda *"!

Smalltalk.Shootout defineClass: #Tests
   superclass: #{Core.Object}
   indexedType: #none
   private: false
   instanceVariableNames: ''
   classInstanceVariableNames: ''
   imports: ''
   category: 'ComputerLanguageShootout' !

!Shootout.Tests class methodsFor: 'benchmark scripts'!

fasta2
   self fasta2: CEnvironment argv first asNumber to: Stdout ! !

!Shootout.Tests class methodsFor: 'benchmarks'!

fasta2: n to: out
   | r lineLength |
   lineLength := 60.
   self
      writeFasta: 'ONE Homo sapiens alu'
      from:
         ( RepeatStream
            to: n*2
            on:'GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG',
               'GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA',
               'CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT',
               'ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA',
               'GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG',
               'AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC',
               'AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA' )
      to: out
      lineLength: lineLength.

   r := RandomNumber to: 1. "Shared random sequence"

   self
      writeFasta: 'TWO IUB ambiguity codes'
      from:
         (( RandomStream2
            to: n*3
            on: #(   #($a 0.27d)
                  #($c 0.12d)
                  #($g 0.12d)
                  #($t 0.27d)

                  #($B 0.02d)
                  #($D 0.02d)
                  #($H 0.02d)
                  #($K 0.02d)
                  #($M 0.02d)
                  #($N 0.02d)
                  #($R 0.02d)
                  #($S 0.02d)
                  #($V 0.02d)
                  #($W 0.02d)
                  #($Y 0.02d)))
         random: r;
         yourself)
      to: out
      lineLength: lineLength.

   self
      writeFasta: 'THREE Homo sapiens frequency'
      from:
         (( RandomStream2
            to: n*5
            on: #(   #($a 0.3029549426680d)
                  #($c 0.1979883004921d)
                  #($g 0.1975473066391d)
                  #($t 0.3015094502008d)))
            random: r;
            yourself)
      to: out
      lineLength: lineLength.

   out flush.
   ^'' ! !

!Shootout.Tests class methodsFor: 'auxillaries'!

writeFasta: aString from: inStream to: outStream lineLength: lineLength
   | i |
   outStream nextPut: $>; nextPutAll: aString; cr.
   i := 0.
   [inStream atEnd] whileFalse:
      [i == lineLength ifTrue: [outStream cr. i := 0].
      outStream nextPut: inStream next.
      i := i + 1].
   outStream cr ! !


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


Smalltalk.Shootout defineClass: #RandomStream2
   superclass: #{Shootout.RepeatStream}
   indexedType: #none
   private: false
   instanceVariableNames: 'random percentages'
   classInstanceVariableNames: ''
   imports: ''
   category: 'Shootout'!

!Shootout.RandomStream2 methodsFor: 'initialize-release'!

on: aCollection
   | size cp |
   repeatPtr := 0.
   random := RandomNumber to: 1.0.
   size := aCollection size.
   percentages := Array new: size.
   collection := Array new: size.
   cp := 0.0d.
   1 to: size do: [:i| 
      collection at: i put: (aCollection at: i) first.
      percentages at: i put: (cp := cp + (aCollection at: i) last)] ! !

!Shootout.RandomStream2 methodsFor: 'accessing'!

next
   | r |
   r := random next.
   repeatPtr := repeatPtr + 1.
   1 to: percentages size do: [:i| 
      (r < (percentages at: i)) ifTrue: [^collection at: i]] ! 

random: aRandomNumber
"* Share the random number generator so we can get the expected results. *"
   random := aRandomNumber ! !


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


