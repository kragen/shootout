"* The Computer Language Shootout
    http://shootout.alioth.debian.org/
    contributed by Eliot Miranda *"!
!Tests class methodsFor: 'benchmarking'!reverseComplementFrom: input named: sequenceName to: output
   | complement idString newline description char |
   complement := String new: 128.

   'ACGTUMRWSYKVHDBN' with: 
   'TGCAAKYWSRMBDHVN'
      do: [:a :b|
         complement at: a asInteger put: b.
         complement at: a asLowercase asInteger put: b].

   idString := '>' , sequenceName.
   newline := Character lf.

   "* find start of particular fasta sequence *"
   [char := input peek.
    char == nil ifTrue: [^self].
   char = $>
      ifTrue:
         [((description := input upTo: newline) 
            indexOfSubCollection: idString startingAt: 1) = 1]
      ifFalse:
         [input skipThrough: newline.
         false]]
      whileFalse.

   output nextPutAll: description; nextPut: newline.
   [(char := input peek) = $> or: [char == nil]] whileFalse:
      [char = $;
         ifTrue: [input skipUpTo: newline]
         ifFalse:
            [[(char := input next) = newline] whileFalse:
               [output nextPut: (complement at: char asInteger)].
             output nextPut: newline]] ! !


!Tests class methodsFor: 'benchmark scripts'!
revcomp
   #('ONE' 'TWO' 'THREE') do:
      [:sequenceName | 
         self reverseComplementFrom: self stdin named: sequenceName to: self stdout].

   self stdout flush.   ^''! !
