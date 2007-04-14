"* The Computer Language Shootout
    http://shootout.alioth.debian.org/
    contributed by Eliot Miranda *"!


!Tests class methodsFor: 'benchmarking'!
readFasta: anId from: input
   | idString newline buffer char |
   idString := '>' , anId.
   newline := Character lf.

   "* find start of particular fasta sequence *"

   [(char := input peek) == nil
    or: [char = $>
         ifTrue:
            [((input upTo: newline)
               indexOfSubCollection: idString startingAt: 1) = 1]
         ifFalse:
            [input skipThrough: newline.
             false]]]
      whileFalse.

   "* line-by-line read - it would be a lot faster to block read *"

   buffer := ReadWriteStream on: (String new: 1028).
   [(char := input peek) == nil or: [char = $>]] whileFalse:
      [char = $;
         ifTrue: [input upTo: newline]
         ifFalse: [buffer nextPutAll: (input upTo: newline)]].
   ^buffer contents ! !

!Tests class methodsFor: 'benchmarking'!
knucleotideFrom: input to: output
   | sequence writeFrequencies writeCount |

! !
!Tests class methodsFor: 'benchmark scripts'!
knucleotide   self knucleotideFrom: self arg to: self stdout.   ^''! !
