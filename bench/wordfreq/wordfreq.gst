"  The Great Computer Language Shootout
   contributed by Isaac Gouy

   To run: gst -Q wordfreq.st < input.txt > out.txt
"


!Bag methodsFor: 'extracting items'!
sortedByCountAndKey
   | counts |
   counts := (SortedCollection new: contents size) sortBlock: [:a :b| 
      a value = b value ifTrue: [a key > b key] ifFalse: [a value > b value] ].

   contents keysAndValuesDo: [:key :count| counts add: key -> count].
   ^counts ! !


| stream wordBuffer wordCounts char space |
stream := FileStream stdin bufferSize: 4096.
wordBuffer := ReadWriteStream on: (String new: 32).
wordCounts := Bag new: 75000.

[(char := stream next) notNil] whileTrue: [ | word |
   char isLetter
      ifTrue: [wordBuffer nextPut: char asLowercase]
      ifFalse: 
        [wordBuffer position > 0
            ifTrue: 
              [word := wordBuffer contents.
               wordBuffer reset.
               wordCounts add: word.
              ].
        ].
].

wordBuffer position > 0
   ifTrue: [wordCounts add: wordBuffer contents].

space := Character space.
wordCounts sortedByCountAndKey do: [:each| | number |
   number := each value printString.
   (7 - number size) timesRepeat: [Transcript nextPut: space].
   Transcript nextPutAll: number; nextPut: space; nextPutAll: each key; cr] !