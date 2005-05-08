"  The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Isaac Gouy

   To run: gst -QI /usr/share/gnu-smalltalk/gst.im nsieve.st -a 7
"


!Integer methodsFor: 'shootout'!

nsieve: isPrime
   | count |
   count := 0.

   2 to: self do: [:i| isPrime at: i put: true].

   2 to: self do: [:i|
      (isPrime at: i) ifTrue: [
         i+i to: self by: i do: [:k| isPrime at: k put: false].
         count := count + 1.
         ].
      ].

   ^count ! 


asPaddedString: anInteger
   | s |
   s := self printString.
   ^(String new: (anInteger - s size) withAll: $ ), s ! !



| n flags m |
n := Smalltalk arguments first asInteger.
(n < 2) ifTrue: [n := 2].

m := (2 raisedTo: n) * 10000.
flags := Array new: m.

Transcript 
   show: 'Primes up to '; show: (m asPaddedString: 8); 
   show: ((m nsieve: flags) asPaddedString: 8); nl.

m := (2 raisedTo: (n - 1)) * 10000.
Transcript 
   show: 'Primes up to '; show: (m asPaddedString: 8); 
   show: ((m nsieve: flags) asPaddedString: 8); nl.

m := (2 raisedTo: (n - 2)) * 10000.
Transcript 
   show: 'Primes up to '; show: (m asPaddedString: 8); 
   show: ((m nsieve: flags) asPaddedString: 8); nl. !




"
  vim: ts=4 ft=st
"
