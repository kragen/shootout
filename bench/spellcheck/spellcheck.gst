"  The Great Computer Language Shootout
   contributed by Isaac Gouy

   To run: gst -Q spellcheck.st < input.txt
"

| dict stream newWord |
dict := Set new: 4096.
stream := (File name: 'Usr.Dict.Words') readStream.
[stream atEnd] whileFalse: [dict add: stream nextLine].
stream close.

stream := FileStream stdin bufferSize: 4096.
[stream atEnd] whileFalse: [
   (dict includes: (newWord := stream nextLine)) 
      ifFalse: [Transcript show: newWord; cr] ] !