"* The Computer Language Benchmarks Game
    http://shootout.alioth.debian.org/
    contributed by Paolo Bonzini *"!

Array subclass: #DoubleArray!
DoubleArray shape: #double!

!DoubleArray methodsFor: 'benchmarking'!
multiplyAtAv
   ^(self multiplyAv) multiplyAtv! !

!DoubleArray methodsFor: 'benchmarking'!
multiplyAtv
   | n atv sum |
   n := self size.
   atv := DoubleArray new: n.
   1 to: n do: [:i|
      sum := 0.0d.
      1 to: n do: [:j|
         sum := sum + ((j matrixA: i) * (self at: j)) ].
      atv at: i put: sum].
   ^atv! !

!DoubleArray methodsFor: 'benchmarking'!
multiplyAv
   | n av sum |
   n := self size.
   av := DoubleArray new: n.
   1 to: n do: [:i|
      sum := 0.0d.
      1 to: n do: [:j|
         sum := sum + ((i matrixA: j) * (self at: j)) ].
      av at: i put: sum].
   ^av! !


!SmallInteger methodsFor: 'benchmarking'!
matrixA: anInteger
   ^1.0d0 / ((self + anInteger - 2) * (self + anInteger - 1) /2  + self)! !


!Tests class methodsFor: 'benchmarking'!
spectralnorm: n
   | u v vBv vv |
   u := DoubleArray new: n withAll: 1.0d0.
   10 timesRepeat:
      [v := u multiplyAtAv.
       u := v multiplyAtAv].
   vBv := 0.0d0.
   vv := 0.0d0.
   1 to: n do:
      [:i |
       vBv := vBv + ((u at: i) * (v at: i)).
       vv := vv + ((v at: i) * (v at: i))].
   ^(vBv / vv) sqrt! !


!Tests class methodsFor: 'benchmark scripts'!
spectralnorm
   self stdout print: (self spectralnorm: self arg) digits: 9; nl.
   ^''! !

Tests spectralnorm!
