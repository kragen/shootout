"  The Great Computer Language Shootout
   http://shootout.alioth.debian.org/ 
   
   contributed by Isaac Gouy
   
   To run: gst -QI /usr/share/gnu-smalltalk/gst.im reversefile < input.txt 
"

((FileStream stdin bufferSize: 4096) splitAt: Character nl)
   reverseDo: [ :each | stdout nextPutAll: each; nl ]!