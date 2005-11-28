"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy"!

!ComputerLanguageShootout.Benchmarks class methodsFor: 'benchmarking'!

spectralnorm: argvString
   | n u v vBv vv answer |
   n := argvString asNumber.
   u := Array new: n withAll: 1.0d.
   v := Array new: n withAll: 0.0d.

   1 to: 10 do: [:i|
      v := u multiplyAtAv.
      u := v multiplyAtAv.
   ].

   vBv := 0.0d.
   vv := 0.0d.
   1 to: n do: [:i| 
      vBv := vBv + ((u at: i) * (v at: i)).
      vv := vv + ((v at: i) * (v at: i)).
   ].  
 
   answer := (vBv/vv) sqrt.
   OS.Stdout nextPutAll: ((answer asFixedPoint: 9) printString copyWithout: $s); cr! !


!Core.Integer methodsFor: 'computer language shootout'!

matrixA: anInteger
"fixup one-based indexing to zero-based indexing - cleanup later"
   | i j |
   i := self - 1. 
   j := anInteger - 1.
   ^1.0d / (i + j * (i + j + 1) /2  + i + 1) asDouble! !


!Core.Array methodsFor: 'computer language shootout'!

multiplyAv
   | n av |
   n := self size.
   av := Array new: n withAll: 0.0d.
   1 to: n do: [:i| 	
      1 to: n do: [:j|
         av at: i put: (av at: i) + ((i matrixA: j) * (self at: j)) ]].
   ^av! !

!Core.Array methodsFor: 'computer language shootout'!

multiplyAtv
   | n atv |
   n := self size.
   atv := Array new: n withAll: 0.0d.
   1 to: n do: [:i| 	
      1 to: n do: [:j|
         atv at: i put: (atv at: i) + ((j matrixA: i) * (self at: j)) ]].
   ^atv! !

!Core.Array methodsFor: 'computer language shootout'!

multiplyAtAv
   ^(self multiplyAv) multiplyAtv! !
