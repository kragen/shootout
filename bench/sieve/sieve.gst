"  The Great Computer Language Shootout
   contributed by Isaac Gouy
   
   To run: gst -QI /usr/share/gnu-smalltalk/gst.im sieve.st -a 900
"

| n start stop isPrime count |
n := Smalltalk arguments first asInteger.

start := 2. stop := 8192. 
isPrime := Array new: stop.

n timesRepeat: [
   count := 0.
   start to: stop do: [:i| isPrime at: i put: true].

   start to: stop do: [:i|
      (isPrime at: i) ifTrue: [ 
         i+i to: stop by: i do: [:j| isPrime at: j put: false].
         count := count + 1.
      ].
   ].
].

Transcript show: 'Count: ', count printString; nl !
