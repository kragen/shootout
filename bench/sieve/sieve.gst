"  The Great Computer Language Shootout
   contributed by Isaac Gouy

   To run: gst -Q sieve.st -a 900
"

| n start stop flags count |
n := (Smalltalk arguments at: 1) asInteger.

start := 2. stop := 8192. 
flags := ByteArray new: stop.
n timesRepeat: [
   count := 0.
   start to: stop do: [:i| flags at: i put: 8r1].
   start to: stop do: [:i|
      (flags at: i) = 8r1 ifTrue: [ 
         i+i to: stop by: i do: [:k| flags at: k put: 8r0].
         count := count + 1.
      ].
   ].
].

Transcript show: 'Count: '; count displayString; cr !