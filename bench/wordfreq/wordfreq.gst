"  The Great Computer Language Shootout
   contributed by Isaac Gouy & Paolo Bonzini
    
   To run: gst -QI /usr/share/gnu-smalltalk/gst.im wordfreq.st < input.txt
"

!Bag methodsFor: 'extracting items'!

sortedByValueAndKey
   | assocs |
   assocs := (SortedCollection new: contents size) sortBlock: [:a :b| 
   a value = b value ifTrue: [a key > b key] ifFalse: [a value > b value] ].

   contents keysAndValuesDo: [:key :value| assocs add: key -> value].
   ^assocs ! !
   
   
| stream wordCounts |
stream := FileStream stdin bufferSize: 4096.
wordCounts := Bag new.

[stdin atEnd] whileFalse: [
   (stream nextLine collect: [:each|
      each isLetter ifTrue: [each asLowercase] ifFalse: [$ ]])
         subStrings do: [:word| wordCounts add: word]
].

wordCounts sortedByValueAndKey do: [:each| | number |
   number := each value printString.
   (7 - number size) timesRepeat: [stdout nextPut: $ ]. 
   stdout nextPutAll: number; nextPutAll: ' '; nextPutAll: each key; nl.
] !
