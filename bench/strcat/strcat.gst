"  The Great Computer Language Shootout
   contributed by Isaac Gouy

   To run: gst -QI /usr/local/share/smalltalk/gst.im strcat.st -a 40000
"

| n stream hello |
n := Smalltalk arguments first asInteger.

stream := WriteStream on: String new.
hello := 'hello', Character nl asString. 
n timesRepeat: [stream nextPutAll: hello].
stream position displayNl !