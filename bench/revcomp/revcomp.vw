"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy *"!

!Shootout.Tests class methodsFor: 'benchmarking'!

revcomp
   | stdin stdout fasta |
   stdin := ExternalReadStream on: 
      (ExternalConnection ioAccessor: (UnixDiskFileAccessor new handle: 0)).
   stdout := ExternalWriteStream on: 
      (ExternalConnection ioAccessor: (UnixDiskFileAccessor new handle: 1)).

   fasta := stdin readFasta: 'ONE'.
   stdout writeReverseComplementFasta: fasta key sequence: fasta value.

   fasta := stdin readFasta: 'TWO'.
   stdout writeReverseComplementFasta: fasta key sequence: fasta value.

   fasta := stdin readFasta: 'THREE'.
   stdout writeReverseComplementFasta: fasta key sequence: fasta value.

   stdout flush. 
   ^'' ! !

 
!ExternalReadStream methodsFor: 'accessing'!

readFasta: anId 
   | idString newline buffer description line char |
   idString := '>',anId.
   newline := Character cr.

   "* find start of particular fasta sequence *"
   [(self atEnd) or: [
         (self peek = $>) 
            ifTrue: [((line := self upTo: newline) 
               indexOfSubCollection: idString startingAt: 1) = 1]
            ifFalse: [self skipThrough: newline. false]]
      ] whileFalse.

   "* line-by-line read - it would be a lot faster to block read *"
   description := line.
   buffer := ReadWriteStream on: (String new: 1028).
   [(self atEnd) or: [(char := self peek) = $>]] whileFalse: [
      (char = $;) 
         ifTrue: [self upTo: newline] 
         ifFalse: [buffer nextPutAll: (self upTo: newline)]
      ].
   ^Association key: description value: buffer contents ! !


!ExternalwriteStream methodsFor: 'accessing'!

writeReverseComplementFasta: aString sequence: aSequence
   | lineLength n iub |
   (aString isNil) ifTrue: [^self].

   lineLength := 60. n := aSequence size.

   iub := String new: 128 withAll: $*.
   iub at: $a asInteger put: $T. iub at: $A asInteger put: $T.
   iub at: $b asInteger put: $V. iub at: $B asInteger put: $V.
   iub at: $c asInteger put: $G. iub at: $C asInteger put: $G.
   iub at: $d asInteger put: $H. iub at: $D asInteger put: $H.
   iub at: $g asInteger put: $C. iub at: $G asInteger put: $C.
   iub at: $h asInteger put: $D. iub at: $H asInteger put: $D.
   iub at: $k asInteger put: $M. iub at: $K asInteger put: $M.
   iub at: $m asInteger put: $K. iub at: $M asInteger put: $K.
   iub at: $n asInteger put: $N. iub at: $N asInteger put: $N.
   iub at: $r asInteger put: $Y. iub at: $R asInteger put: $Y.
   iub at: $s asInteger put: $S. iub at: $S asInteger put: $S.
   iub at: $t asInteger put: $A. iub at: $T asInteger put: $A.
   iub at: $v asInteger put: $B. iub at: $V asInteger put: $B.
   iub at: $w asInteger put: $W. iub at: $W asInteger put: $W.
   iub at: $y asInteger put: $R. iub at: $Y asInteger put: $R.

   self nextPutAll: aString; cr.

   [n > 0] whileTrue: [ 
         1 to: ((n < lineLength) ifTrue: [n] ifFalse: [lineLength]) do:
            [:i | self nextPut: (iub at: (aSequence at: n - i + 1) asInteger)].
         self cr.
         n := n - lineLength. 
      ] ! !
