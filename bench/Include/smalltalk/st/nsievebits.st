"* The Computer Language Shootout
    http://shootout.alioth.debian.org/
    contributed by Isaac Gouy
    modified by Eliot Miranda *"!

ArrayedCollection variableByteSubclass: #BitArray   instanceVariableNames: ''   classVariableNames: ''   poolDictionaries: ''   category: 'Shootout'!

!BitArray methodsFor: 'accessing'!at: index    | wordIndex bitMask |    wordIndex := ((index - 1) bitShift: -3) + 1.    bitMask := 1 bitShift: (index - 1 bitAnd: 7).    ^((self basicAt: wordIndex) bitAnd: bitMask) > 0! !
!BitArray methodsFor: 'accessing'!at: index put: bit    | wordIndex bitMask word |    wordIndex := ((index - 1) bitShift: -3) + 1.    bitMask := 1 bitShift: (index - 1 bitAnd: 7).    word := self basicAt: wordIndex.    word := word bitOr: bitMask.    bit ifFalse: [word := word - bitMask].    self basicAt: wordIndex put: word.    ^bit! !!BitArray methodsFor: 'accessing'!atAllPut: anObject    "Put anObject at every one of the receivers indices."   | value |   value := anObject ifTrue: [255] ifFalse: [0].   1 to: self basicSize do: [:index | self basicAt: index put: value]! !!BitArray class methodsFor: 'instance creation'!new: size    ^super new: (size + 7 bitShift: -3)! !!Tests class methodsFor: 'benchmark scripts'!nsievebits   | n |   n := self arg.   (n < 2) ifTrue: [n := 2].   self primeBenchmarkFor: n to: self stdout using: BitArray.   ^''! !!Tests class methodsFor: 'benchmarking'!nsieve: n using: arrayClass    | count isPrime |   count := 0.   isPrime := arrayClass new: n withAll: true.   2 to: n do:      [:i |       (isPrime at: i) ifTrue:          [i + i to: n by: i do:            [:k | isPrime at: k put: false].         count := count + 1]].   ^count! !!Tests class methodsFor: 'benchmarking'!primeBenchmarkFor: v to: output using: arrayClass   v to: v - 2 by: -1 do:      [:n| | m |      m := (2 raisedTo: n) * 10000.      output         nextPutAll: 'Primes up to '; 
         print: m paddedTo: 8;
         print: (self nsieve: m using: arrayClass) paddedTo: 9; nl
      ]! !
