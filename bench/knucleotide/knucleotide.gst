"* The Computer Language Shootout
    http://shootout.alioth.debian.org/
    contributed by Isaac Gouy *"!


!SequenceableCollection methodsFor: 'computer language shootout'!
substringFrequencies: aLength using: aDictionary
   1 to: self size - aLength + 1 do:
      [:i | | fragment assoc |
      fragment := self copyFrom: i to: i + aLength - 1.

      (assoc := aDictionary associationAt: fragment ifAbsent: []) isNil 
         ifTrue: [aDictionary at: fragment put: 1]
         ifFalse: [assoc value: assoc value + 1] ].
   ^aDictionary ! !


!Tests class methodsFor: 'benchmarking'!
readFasta: sequenceName from: input
   | prefix newline buffer description line char |
   prefix := '>',sequenceName.
   newline := Character lf.

   "* find start of particular fasta sequence *"
   [(input atEnd) or: [
         (input peek = $>) 
            ifTrue: [((line := input upTo: newline) 
               indexOfSubCollection: prefix startingAt: 1) = 1]
            ifFalse: [input skipTo: newline. false]]
      ] whileFalse.

   "* line-by-line read - it would be a lot faster to block read *"
   description := line.
   buffer := ReadWriteStream on: (String new: 1028).
   [(input atEnd) or: [(char := input peek) = $>]] whileFalse: [
      (char = $;) 
         ifTrue: [input upTo: newline] 
         ifFalse: [buffer nextPutAll: (input upTo: newline)]
      ].
   ^Association key: description value: buffer contents ! !

!Tests class methodsFor: 'benchmarking'!
knucleotideFrom: input to: output
   | sequence newline writeFrequencies writeCount |

   sequence := (self readFasta: 'THREE' from: input) value asUppercase.
   newline := Character lf.

   writeFrequencies :=
      [:k | | frequencies count |
      frequencies := SortedCollection sortBlock: [:a :b|
         (a value = b value) ifTrue: [b key < a key] ifFalse: [b value < a value]].

      count := 0.0.
      (sequence substringFrequencies: k using: Dictionary new)
         associationsDo: [:each|
            frequencies add: each. count := count + each value].

      frequencies do: [:each | | percentage |
         percentage := (each value / count) * 100.0.
         output 
            nextPutAll: each key; space;
            print: percentage digits: 3; nl]].

   writeCount := [:nucleotideFragment | | frequencies count |
      frequencies := sequence substringFrequencies: nucleotideFragment size
         using: Dictionary new.
      count := frequencies at: nucleotideFragment ifAbsent: [0].
      output print: count; tab; nextPutAll: nucleotideFragment; nl].

   writeFrequencies value: 1. output nl.
   writeFrequencies value: 2. output nl.

   writeCount value: 'GGT'.
   writeCount value: 'GGTA'.
   writeCount value: 'GGTATT'.
   writeCount value: 'GGTATTTTAATT'.
   writeCount value: 'GGTATTTTAATTTATAGT'.! !
!Tests class methodsFor: 'benchmark scripts'!
knucleotide   self knucleotideFrom: self stdinSpecial to: self stdout.   ^''! !

Tests knucleotide!
