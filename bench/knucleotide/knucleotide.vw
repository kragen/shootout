"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy"!

!Shootout.Tests class methodsFor: 'benchmarking'!

knucleotide
   | stdin sequence writeFrequencies writeCount |
   stdin := ExternalReadStream on: 
      (ExternalConnection ioAccessor: (UnixDiskFileAccessor new handle: 0)).

   sequence := (stdin readFasta: 'THREE') value asUppercase.

   writeFrequencies := [:k | | frequencies count |
      frequencies := SortedCollection sortBlock: [:a :b|
         (a value = b value) ifTrue: [b key < a key] ifFalse: [b value < a value]].

      count := 0.0.
      (sequence substringFrequencies: k)
         associationsDo: [:each| frequencies add: each. count := count + each value].

      frequencies do: [:each | | percentage |
         percentage := (each value / count) * 100.0.
         OS.Stdout nextPutAll: each key; nextPutAll: ' ';
            nextPutAll: (percentage asStringWith: 3); cr.
         ].
   ].

   writeCount := [:nucleotideFragment | | frequencies count |
      frequencies := sequence substringFrequencies: nucleotideFragment size.
      count := frequencies at: nucleotideFragment asSymbol ifAbsent: [0].
      OS.Stdout nextPutAll: count printString; nextPut: Character tab; 
         nextPutAll: nucleotideFragment; cr
   ].

   writeFrequencies value: 1. OS.Stdout cr.
   writeFrequencies value: 2. OS.Stdout cr.

   writeCount value: 'GGT'.
   writeCount value: 'GGTA'.
   writeCount value: 'GGTATT'.
   writeCount value: 'GGTATTTTAATT'.
   writeCount value: 'GGTATTTTAATTTATAGT'.
   ^'' ! !


!String methodsFor: 'computer language shootout'!

substringFrequencies: aLength
   | answer |
   answer := IdentityDictionary new.
   1 to: aLength do: [:i |
      self inject: answer intoSubstringFrequencies: aLength offset: i].
   ^answer !

inject: aDictionary intoSubstringFrequencies: aLength offset: anInteger
   anInteger to: self size - aLength + 1 by: aLength do: [:i |
      | fragment value |
      fragment := (self copyFrom: i to: i + aLength - 1) asSymbol.

      value := aDictionary at: fragment ifAbsent: [ 0 ].
      aDictionary at: fragment put: value + 1 
   ] ! !


!ExternalReadStream methodsFor: 'accessing'!

readFasta: anId 
   | idString newline buffer description line char |
   idString := '>',anId.
   newline := Character cr.

   "find start of particular fasta sequence"
   [(self atEnd) or: [
         (self peek = $>) 
            ifTrue: [((line := self upTo: newline) 
               indexOfSubCollection: idString startingAt: 1) = 1]
            ifFalse: [self skipThrough: newline. false]]
      ] whileFalse.

   "line-by-line read - it would be a lot faster to block read"
   description := line.
   buffer := ReadWriteStream on: (String new: 1028).
   [(self atEnd) or: [(char := self peek) = $>]] whileFalse: [
      (char = $;) 
         ifTrue: [self upTo: newline] 
         ifFalse: [buffer nextPutAll: (self upTo: newline)]
      ].
   ^Association key: description value: buffer contents ! !
