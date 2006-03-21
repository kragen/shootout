"* The Computer Language Shootout
 http://shootout.alioth.debian.org/
 contributed by Isaac Gouy *"


! FileStream methodsFor: 'accessing'!

readFasta: anId 
   | idString newline buffer description line char |
   idString := '>',anId.
   newline := Character nl.

   "* find start of particular fasta sequence *"
   [(self atEnd) or: [
         (self peek = $>) 
            ifTrue: [(line := self nextLine) startsWith: idString]
            ifFalse: [self skipTo: newline. false]]
      ] whileFalse.

   "* line-by-line read - it would be a lot faster to block read *"
   description := line.
   buffer := ByteStream on: (String new: 1028).
   [(self atEnd) or: [(char := self peek) = $>]] whileFalse: [
      (char = $;) 
         ifTrue: [self nextLine] 
         ifFalse: [buffer nextPutAll: self nextLine]
      ].

   ^Association key: description value: buffer contents !


writeReverseComplementFasta: aString sequence: aSequence
   | lineLength n iub |
   (aString isNil) ifTrue: [^self].

   lineLength := 60. n := aSequence size.

   iub := String new: 128 withAll: $*.
   iub at: $a value put: $T. iub at: $A value put: $T.
   iub at: $b value put: $V. iub at: $B value put: $V.
   iub at: $c value put: $G. iub at: $C value put: $G.
   iub at: $d value put: $H. iub at: $D value put: $H.
   iub at: $g value put: $C. iub at: $G value put: $C.
   iub at: $h value put: $D. iub at: $H value put: $D.
   iub at: $k value put: $M. iub at: $K value put: $M.
   iub at: $m value put: $K. iub at: $M value put: $K.
   iub at: $n value put: $N. iub at: $N value put: $N.
   iub at: $r value put: $Y. iub at: $R value put: $Y.
   iub at: $s value put: $S. iub at: $S value put: $S.
   iub at: $t value put: $A. iub at: $T value put: $A.
   iub at: $v value put: $B. iub at: $V value put: $B.
   iub at: $w value put: $W. iub at: $W value put: $W.
   iub at: $y value put: $R. iub at: $Y value put: $R.

   self nextPutAll: aString; nl.

   [n > 0] whileTrue: [ 
         1 to: ((n < lineLength) ifTrue: [n] ifFalse: [lineLength]) do:
            [:i | self nextPut: (iub at: (aSequence at: n - i + 1) value)].
         self nl.
         n := n - lineLength. 
      ] ! !


| in out fasta |
in := FileStream stdin bufferSize: 4096.
out := FileStream stdout bufferSize: 4096.

fasta := in readFasta: 'ONE'.
out writeReverseComplementFasta: fasta key sequence: fasta value.

fasta := in readFasta: 'TWO'.
out writeReverseComplementFasta: fasta key sequence: fasta value.

fasta := in readFasta: 'THREE'.
out writeReverseComplementFasta: fasta key sequence: fasta value.

in close. out close !
