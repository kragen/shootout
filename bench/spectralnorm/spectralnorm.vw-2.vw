"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy
   modified by Eliot Miranda *"!


Smalltalk.Shootout defineClass: #Tests
   superclass: #{Core.Object}
   indexedType: #none
   private: false
   instanceVariableNames: ''
   classInstanceVariableNames: ''
   imports: ''
   category: 'ComputerLanguageShootout' !

!Shootout.Tests class methodsFor: 'benchmark scripts'!

spectralnorm
   ^self spectralnorm: CEnvironment argv first asNumber ! !

!Shootout.Tests class methodsFor: 'benchmarks'!

spectralnorm: n 
   | u v vBv vv |
   u := Array new: n withAll: 1.0d.
   v := Array new: n withAll: 0.0d.
   10 timesRepeat: 
      [v := u multiplyAtAv.
       u := v multiplyAtAv].
   vBv := 0.0d.
   vv := 0.0d.
   1 to: n do: 
      [:i | 
       vBv := vBv + ((u at: i) * (v at: i)).
       vv := vv + ((v at: i) * (v at: i))].
   ^((vBv / vv) sqrt asStringWith: 9) withNl ! !



!Core.SmallInteger methodsFor: 'computer language shootout'!

matrixA: anInteger
"fixup one-based indexing to zero-based indexing - cleanup later"
   | i j |
   i := self - 1. 
   j := anInteger - 1.
   ^1.0d / (i + j * (i + j + 1) /2  + i + 1) asDouble ! !


!Core.Array methodsFor: 'computer language shootout'!

multiplyAv
   | n av |
   n := self size.
   av := Array new: n withAll: 0.0d.
   1 to: n do: [:i|    
      1 to: n do: [:j|
         av at: i put: (av at: i) + ((i matrixA: j) * (self at: j)) ]].
   ^av ! !

!Core.Array methodsFor: 'computer language shootout'!

multiplyAtv
   | n atv |
   n := self size.
   atv := Array new: n withAll: 0.0d.
   1 to: n do: [:i|    
      1 to: n do: [:j|
         atv at: i put: (atv at: i) + ((j matrixA: i) * (self at: j)) ]].
   ^atv ! !

!Core.Array methodsFor: 'computer language shootout'!

multiplyAtAv
   ^(self multiplyAv) multiplyAtv ! !
