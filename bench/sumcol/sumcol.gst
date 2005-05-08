"  The Great Computer Language Shootout
   contributed by Isaac Gouy
   
   To run: gst -QI /usr/share/gnu-smalltalk/gst.im sumcol.st < input.txt
"

| sum inStream |
sum := 0.
inStream := FileStream stdin bufferSize: 4096.
[inStream atEnd] whileFalse: [
   sum := sum + inStream nextLine asInteger].
   
Transcript show: sum displayString; nl !
