"  The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Isaac Gouy

   To run: gst -QI /usr/share/gnu-smalltalk/gst.im spectralnorm.st -a 100 
"

!Integer methodsFor: 'spectral-norm'!

matrixA: anInteger
"fixup one-based indexing to zero-based indexing - cleanup later"
   | i j |
   i := self - 1. 
   j := anInteger - 1.
   ^1.0d / (i + j * (i + j + 1) /2  + i + 1) asFloatD ! !


!Array methodsFor: 'spectral-norm'!

multiplyAv
   | n av |
   n := self size.
   av := Array new: n withAll: 0.0d.
   1 to: n do: [:i| 	
      1 to: n do: [:j|
         av at: i put: (av at: i) + ((i matrixA: j) * (self at: j)) ]].
   ^av ! 
   
multiplyAtv
   | n atv |
   n := self size.
   atv := Array new: n withAll: 0.0d.
   1 to: n do: [:i| 	
      1 to: n do: [:j|
         atv at: i put: (atv at: i) + ((j matrixA: i) * (self at: j)) ]].
   ^atv !
      
multiplyAtAv
   ^(self multiplyAv) multiplyAtv ! !
   
   
!Float methodsFor: 'printing'!

printStringRoundedTo: anInteger
   | n s |
   n := 0.5d * (10 raisedToInteger: anInteger negated).
   s := ((self sign < 0) ifTrue: [self - n] ifFalse: [self + n]) printString.
   ^s copyFrom: 1 to: (s indexOf: $.) + anInteger ! !
   
   
| n u v vBv vv |
n := Smalltalk arguments first asInteger.
u := Array new: n withAll: 1.0d.
v := Array new: n withAll: 0.0d.

10 timesRepeat: [
   v := u multiplyAtAv.
   u := v multiplyAtAv.
].

vBv := 0.0d.
vv := 0.0d.
1 to: n do: [:i| 
   vBv := vBv + ((u at: i) * (v at: i)).
   vv := vv + ((v at: i) * (v at: i)).
].  
 
((vBv/vv) sqrt printStringRoundedTo: 9) displayNl !
