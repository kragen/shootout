"  The Great Computer Language Shootout
   contributed by Isaac Gouy

   To run: gst -QI /usr/local/share/smalltalk/gst.im fibo.st -a 32
"

!Integer methodsFor: 'shootout'!

fibonacci
   ^self < 2 
      ifTrue: [1] 
      ifFalse: [(self - 2) fibonacci + (self - 1) fibonacci] ! !

Transcript show: Smalltalk arguments first asInteger fibonacci printString; nl !