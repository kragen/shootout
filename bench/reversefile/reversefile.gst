"  The Great Computer Language Shootout
   contributed by Isaac Gouy

   To run: gst -Q reversefile.st < input.txt > out.txt
"

((FileStream stdin bufferSize: 4096) splitAt: Character nl)
   reverseDo: [:each| Transcript nextPutAll: each; cr] !