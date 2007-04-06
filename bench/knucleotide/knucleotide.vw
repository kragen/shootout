"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy
   modified by Eliot Miranda *"!


Smalltalk.Shootout defineClass: #Tests
   superclass: #{Core.Object}
   indexedType: #none
   private: false
   instanceVariableNames: ''
   classInstanceVariableNames: ''
   imports: ''
   category: 'ComputerLanguageShootout' !

!Shootout.Tests class methodsFor: 'benchmark scripts'!

knucleotide
   self knucleotideFrom: Stdin to: Stdout.
   ^'' !

!Shootout.Tests class methodsFor: 'benchmarks'!

knucleotideFrom: input to: output
   | sequence writeFrequencies writeCount |

   sequence := (self readFasta: 'THREE' from: input) asUppercase.

   writeFrequencies := [:k | | frequencies count |
      frequencies := SortedCollection sortBlock: [:a :b|
         (a value = b value) ifTrue: [b key < a key] ifFalse: [b value < a value]].

      count := 0.0.
      (sequence substringFrequencies: k)
         associationsDo: [:each| frequencies add: each. count := count + each value].

      frequencies do: [:each | | percentage |
         percentage := (each value / count) * 100.0.
         output nextPutAll: each key; space; 
         nextPutAll: (percentage asStringWith: 3); cr]].

   writeCount :=
   [:nucleotideFragment | | frequencies count |
      frequencies := sequence substringFrequencies: nucleotideFragment size.
      count := frequencies at: nucleotideFragment ifAbsent: [0].
      output print: count; tab; nextPutAll: nucleotideFragment; cr].

   writeFrequencies value: 1. output cr.
   writeFrequencies value: 2. output cr.

   writeCount value: 'GGT'.
   writeCount value: 'GGTA'.
   writeCount value: 'GGTATT'.
   writeCount value: 'GGTATTTTAATT'.
   writeCount value: 'GGTATTTTAATTTATAGT'.
   ^'' !

!Shootout.Tests class methodsFor: 'auxilliaries'!

readFasta: anId from: input 
   | idString newline buffer char |
   idString := '>' , anId.
   newline := Character cr.

   "find start of particular fasta sequence"
   
   [(char := input peek) == nil
    or: [char = $> 
         ifTrue: 
            [((input upTo: newline) 
               indexOfSubCollection: idString startingAt: 1) = 1]
         ifFalse: 
            [input skipThrough: newline.
             false]]] 
      whileFalse.

   "line-by-line read - it would be a lot faster to block read"
   buffer := ReadWriteStream on: (String new: 1028).
   [(char := input peek) == nil or: [char = $>]] whileFalse: 
      [char = $; 
         ifTrue: [input upTo: newline]
         ifFalse: [buffer nextPutAll: (input upTo: newline)]].
   ^buffer contents ! !


!Core.String methodsFor: 'computer language shootout'!

substringFrequencies: aLength 
   | answer |
   answer := Dictionary new: 1024.
   1 to: aLength do:
      [:i |
      self inject: answer intoSubstringFrequencies: aLength offset: i].
   ^answer ! 

inject: aDictionary intoSubstringFrequencies: aLength offset: anInteger 
   anInteger to: self size - aLength + 1 by: aLength do:
      [:i | | fragment value |
      fragment := self copyFrom: i to: i + aLength - 1.
      value := aDictionary at: fragment ifAbsent: [0].
      aDictionary at: fragment put: value + 1] ! !


