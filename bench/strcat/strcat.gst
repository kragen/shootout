"  The Great Computer Language Shootout
   contributed by Isaac Gouy

   To run: gst -Q strcat.st -a 40000
"

| n stream hello |
n := (Smalltalk arguments at: 1) asInteger.

stream := WriteStream on: (String new: 32).
hello := 'hello', Character nl asString. 
n timesRepeat: [stream nextPutAll: hello].
stream position displayNl !