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

   ^Association key: description value: buffer contents ! !


! ByteArray methodsFor: 'analysis'!

substringFrequencies: aLength
   | answer | 
   answer := Dictionary new.
   1 to: aLength do: [:i | 
      self inject: answer intoSubstringFrequencies: aLength offset: i].
   ^answer ! 

inject: aDictionary intoSubstringFrequencies: aLength offset: anInteger
   anInteger to: self size - aLength + 1 by: aLength do: [:i | 
      | fragment assoc | 
      fragment := self copyFrom: i to: i + aLength - 1.
      (assoc := aDictionary associationAt: fragment ifAbsent: []) isNil 
         ifTrue: [aDictionary at: fragment put: 1]
         ifFalse: [assoc value: assoc value + 1] ] ! 


replaceLowercaseFasta
   | upper |
   upper := ByteArray new: 128 withAll: $* value.
   upper at: $a value put: $A value. upper at: $A value put: $A value.
   upper at: $b value put: $B value. upper at: $B value put: $B value.
   upper at: $c value put: $C value. upper at: $C value put: $C value.
   upper at: $d value put: $D value. upper at: $D value put: $D value.
   upper at: $g value put: $G value. upper at: $G value put: $G value.
   upper at: $h value put: $H value. upper at: $H value put: $H value.
   upper at: $k value put: $K value. upper at: $K value put: $K value.
   upper at: $m value put: $M value. upper at: $M value put: $M value.
   upper at: $n value put: $N value. upper at: $N value put: $N value.
   upper at: $r value put: $R value. upper at: $R value put: $R value.
   upper at: $s value put: $S value. upper at: $S value put: $S value.
   upper at: $t value put: $T value. upper at: $T value put: $T value.
   upper at: $v value put: $V value. upper at: $V value put: $V value.
   upper at: $w value put: $W value. upper at: $W value put: $W value.
   upper at: $y value put: $Y value. upper at: $Y value put: $Y value.

   1 to: self size do: [:i| | byte | byte := self at: i.
       self at: i put: (upper at: byte)] ! !


!Float methodsFor: 'printing'!

printStringRoundedTo: anInteger
   | n s |
   n := 0.5d * (10 raisedToInteger: anInteger negated).
   s := ((self sign < 0) ifTrue: [self - n] ifFalse: [self + n]) printString.
   ^s copyFrom: 1 to: (s indexOf: $.) + anInteger ! !


| sequence writeFrequencies writeCount |
sequence := ((FileStream stdin bufferSize: 4096) readFasta: 'THREE') value.
sequence replaceLowercaseFasta.

writeFrequencies := [:k | | frequencies count |
   frequencies := SortedCollection sortBlock: [:a :b| 
      (a value = b value) ifTrue: [b key < a key] ifFalse: [b value < a value]].

   count := 0.0.
   (sequence substringFrequencies: k) 
      associationsDo: [:each| 
         each key: each key asString.
         frequencies add: each. count := count + each value].

   frequencies do: [:each | | percentage |
      percentage := (each value / count) * 100.0.
      Transcript show: each key; space; 
         show: (percentage printStringRoundedTo: 3); nl.
      ].
].

writeCount := [:nucleotideFragment | | frequencies count |
   frequencies := sequence substringFrequencies: nucleotideFragment size.
   count := frequencies at: nucleotideFragment asByteArray ifAbsent: [0].
   Transcript show: count printString; tab; show: nucleotideFragment; nl
].

writeFrequencies value: 1. Transcript nl.
writeFrequencies value: 2. Transcript nl.

writeCount value: 'GGT'.
writeCount value: 'GGTA'.
writeCount value: 'GGTATT'.
writeCount value: 'GGTATTTTAATT'.
writeCount value: 'GGTATTTTAATTTATAGT' !
