"* The Computer Language Shootout
    http://shootout.alioth.debian.org/
    contributed by Isaac Gouy
    modified by Eliot Miranda *"!!Tests class methodsFor: 'benchmark scripts'!nsieve   | n |   n := self arg.   (n < 2) ifTrue: [n := 2].   self primeBenchmarkFor: n to: self stdout using: Array.   ^''! !!Tests class methodsFor: 'benchmarking'!nsieve: n using: arrayClass    | count isPrime |   count := 0.   isPrime := arrayClass new: n withAll: true.   2 to: n do:      [:i |       (isPrime at: i) ifTrue:          [i + i to: n by: i do:            [:k | isPrime at: k put: false].         count := count + 1]].   ^count! !!Tests class methodsFor: 'benchmarking'!primeBenchmarkFor: v to: output using: arrayClass   v to: v - 2 by: -1 do:      [:n| | m |      m := (2 raisedTo: n) * 10000.      output         nextPutAll: 'Primes up to '; 
         print: m paddedTo: 8;
         print: (self nsieve: m using: arrayClass) paddedTo: 9; nl
      ]! !

Tests nsieve!
