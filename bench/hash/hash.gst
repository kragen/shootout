"  The Great Computer Language Shootout
   contributed by Isaac Gouy (with improvements by Paolo Bonzini)
   
   To run: gst -QI /usr/share/gnu-smalltalk/gst.im hash.st -a 80000
"

| n count table |
n := Smalltalk arguments first asInteger.

count := 0.
table := Set new: n + (n // 5).

1 to: n do: [:each| table add: (each printString: 16)].

1 to: n do: [:each | 
   (table includes: each printString) ifTrue: [count := count + 1] ].
   
Transcript show: count printString; nl !
