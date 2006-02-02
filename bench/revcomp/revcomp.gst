"The Computer Language Shootout
 http://shootout.alioth.debian.org/
 contributed by Isaac Gouy"


! FileStream methodsFor: 'accessing'!

readFasta: anId 
   | idString newline buffer description line char |
   idString := '>',anId.
   newline := Character nl.

   [(self atEnd) or: [
         (self peek = $>) 
            ifTrue: [(line := self nextLine) startsWith: idString]
            ifFalse: [self skipTo: newline. false]]
      ] whileFalse.

   description := line.
   buffer := ByteStream on: ByteArray new.
   [(self atEnd) or: [(char := self peek) = $>]] whileFalse: [
      (char = $;) 
         ifTrue: [self nextLine] 
         ifFalse: [buffer nextPutAll: self nextLine]
      ].

   ^Association key: description value: buffer contents !


writeReverseComplementFasta: aString sequence: aByteArray
   | lineLength n iub |
   (aString isNil) ifTrue: [^self].

   lineLength := 60. n := aByteArray size.

   iub := ByteArray new: 128 withAll: $* value.
   iub at: $a value put: $T value. iub at: $A value put: $T value.
   iub at: $b value put: $V value. iub at: $B value put: $V value.
   iub at: $c value put: $G value. iub at: $C value put: $G value.
   iub at: $d value put: $H value. iub at: $D value put: $H value.
   iub at: $g value put: $C value. iub at: $G value put: $C value.
   iub at: $h value put: $D value. iub at: $H value put: $D value.
   iub at: $k value put: $M value. iub at: $K value put: $M value.
   iub at: $m value put: $K value. iub at: $M value put: $K value.
   iub at: $n value put: $N value. iub at: $N value put: $N value.
   iub at: $r value put: $Y value. iub at: $R value put: $Y value.
   iub at: $s value put: $S value. iub at: $S value put: $S value.
   iub at: $t value put: $A value. iub at: $T value put: $A value.
   iub at: $v value put: $B value. iub at: $V value put: $B value.
   iub at: $w value put: $W value. iub at: $W value put: $W value.
   iub at: $y value put: $R value. iub at: $Y value put: $R value.

   self nextPutAll: aString; nl.

   [n > 0] whileTrue: [ 
         1 to: ((n < lineLength) ifTrue: [n] ifFalse: [lineLength]) do:
            [:i | self nextPutByte: (iub at: (aByteArray at: n - i + 1))].
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
