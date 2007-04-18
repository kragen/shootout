"* The Computer Language Shootout
    http://shootout.alioth.debian.org/
    contributed by Eliot Miranda *"!


!SequenceableCollection methodsFor: 'computer language shootout'!
substringFrequencies: aLength using: aDictionary
   1 to: self size - aLength + 1 do:
      [:i | | fragment |
      fragment := self copyFrom: i to: i + aLength - 1.
      aDictionary at: fragment
         putValueOf: [:sum| sum + 1] ifAbsentPutValueOf: 1].
   ^aDictionary ! !


!Dictionary methodsFor: 'computer language shootout'!
at: key putValueOf: putBlock ifAbsentPutValueOf: absentBlock
   "* Set the value at key to be the value of evaluating putBlock
    with the existing value. If key is not found, create a new
    entry for key and set is value to the evaluation of
    absentBlock. Answer the result of evaluating either block. *"

   | index element anObject |
   key == nil ifTrue:
      [^self
         subscriptBoundsErrorFor: #at:putValueOf:ifAbsentPutValueOf:
         index: key
         value: absentBlock value].
   index := self findKeyOrNil: key.
   element := self basicAt: index.
   element == nil
      ifTrue: [self atNewIndex: index put:
         (self createKey: key value: (anObject := absentBlock value))]
      ifFalse: [element value: (anObject := putBlock value: element value)].
   ^anObject ! !


Dictionary subclass: #DNASequenceDictionary   instanceVariableNames: ''   classVariableNames: ''   poolDictionaries: ''   category: 'Shootout'!

!DNASequenceDictionary methodsFor: 'private'!
findKeyOrNil: key
   "* Look for the key in the receiver.  If it is found, answer
   the index of the association containing the key, otherwise
   answer the index of the first unused slot. *"

   | location length probe pass |
   length := self basicSize.
   pass := 1.
   location := self initialIndexFor: key dnaSequenceHash boundedBy: length.
   [(probe := self basicAt: location) == nil or: [probe key = key]]
      whileFalse:
         [(location := location + 1) > length
            ifTrue:
               [location := 1.
               pass := pass + 1.
               pass > 2 ifTrue: [^self grow findKeyOrNil: key]]].
   ^location ! !


!String methodsFor: 'comparing'!
dnaSequenceHash
   "* Answer a uniformly distributed SmallInteger computed from the contents
      of the receiver, which is a string composed of only the letters ACGT. *"
   "* Each character contributes 2 bts to the hash. Bit positions climb to 28
    before wrapping *"

   | hash bitPosition |
   hash := 0.
   bitPosition := 0.
   1 to: self size do:
      [:i| | c |
      c := self at: i.
      hash := hash + ((c >= $G ifTrue: [c = $G ifTrue: [2] ifFalse: [3]]
         ifFalse: [c = $A ifTrue: [0] ifFalse: [1]]) bitShift: bitPosition).
      (bitPosition := bitPosition + 2) >= 28 ifTrue:
         [bitPosition := 0.
          hash := hash bitAnd: 16rFFFFFFF]].
   ^hash ! !


!Tests class methodsFor: 'benchmarking'!
readFasta: sequenceName from: input
   | prefix newline buffer description line char |
   prefix := '>',sequenceName.
   newline := Character cr.

   "* find start of particular fasta sequence *"
   [(input atEnd) or: [
         (input peek = $>) 
            ifTrue: [((line := input upTo: newline) 
               indexOfSubCollection: prefix startingAt: 1) = 1]
            ifFalse: [input skipThrough: newline. false]]
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
knucleotide2From: input to: output
   | sequence newline writeFrequencies writeCount |

   sequence := (self readFasta: 'THREE' from: input) value asUppercase.
   newline := Character lf.

   writeFrequencies :=
      [:k | | frequencies count |
      frequencies := SortedCollection sortBlock: [:a :b|
         (a value = b value) ifTrue: [b key < a key] ifFalse: [b value < a value]].

      count := 0.0.
      (sequence substringFrequencies: k using: (DNASequenceDictionary new: 1024))
         associationsDo: [:each|
            frequencies add: each. count := count + each value].

      frequencies do: [:each | | percentage |
         percentage := (each value / count) * 100.0.
         output 
            nextPutAll: each key; space;
            print: percentage digits: 3; nl]].

   writeCount := [:nucleotideFragment | | frequencies count |
      frequencies := sequence substringFrequencies: nucleotideFragment size
         using: (DNASequenceDictionary new: 1024).
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
knucleotide2   self knucleotide2From: self stdinSpecial to: self stdout.   ^''! !
