"  The Great Computer Language Shootout
   contributed by Paolo Bonzini

   To run: gst -QI /usr/local/share/smalltalk/gst.im wordfreq.st < input.txt
"

| freq sort |
freq := Bag new.
[ stdin atEnd ] whileFalse: [
   "It is faster to do all the processing on the line we read, that to
   get the substrings, filter out unwanted punctuation, and turn the
   words to lowercase."
	 
   (stdin nextLine collect: [ :each |
      each isLetter ifTrue: [ each asLowercase ] ifFalse: [ $ ]])
         substrings do: [ :word |
            freq add: word withOccurrences: 1 ]].

"Use -1 to work around a bug (the word is left in the table with frequency zero
 if we use #negated: this is not visible with #do:, but it is with #sortedByCount"
 
freq add: '' withOccurrences: -1 - (freq occurrencesOf: '').

"Bag has the #sortedByCount method, but it leaves the values unordered so
 we cannot rely on it.  The string below has seven spaces and a tab."

sort := SortedCollection new.
freq asSet do: [ :each || out freqString |
   out := '       	', each.
   freqString := (freq occurrencesOf: each) printString.
   out replaceFrom: 8 - freqString size to: 7 with: freqString startingAt: 1.
   sort add: out.
].
sort size timesRepeat: [ sort removeLast displayNl ] !