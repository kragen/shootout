"  The Great Computer Language Shootout
   contributed by Isaac Gouy

   To run: gst -Q hash.st -a 80000
"

| n count table buffer key |
n := (Smalltalk arguments at: 1) asInteger.

count := 0.
table := Set new: n + (n // 5).

buffer := ReadWriteStream on: (String new: 32).
1 to: n do: [:i | 
   i printOn: buffer base: 16.
   table add: buffer contents.
   buffer reset.
   ].

1 to: n do: [:i | 
   (table includes: i printString) 
      ifTrue: [count := count + 1] ].

Transcript show: count printString; cr !