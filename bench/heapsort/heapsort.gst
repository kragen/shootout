"  The Great Computer Language Shootout
   contributed by Isaac Gouy

   To run: gst -Q heapsort.st -a 80000
"


!Array methodsFor: 'sorting'!

heapsort
   | j i ir l d dj dj1 |
   j := 0. i := 0. ir := self size.
   l := self size bitShift: -1.  
   
   [true] whileTrue: 
      [  l > 1 
         ifTrue: [
            l := l - 1. 
            d := self at: l]
         ifFalse: [
            d := self at: ir.
            self at: ir put: (self at: 1).
            ir := ir - 1.
            ir = 1 ifTrue: [self at: 1 put: d. ^self] ]. 
         
      i := l.
      j := l bitShift: 1.
      [j <= ir] whileTrue: [
         dj := self at: j.
         dj1 := self at: j + 1.
         (j < ir and: [dj < dj1]) ifTrue: [j := j+1].
         dj := self at: j.
         d < dj
            ifTrue: [self at: i put: dj. i := j. j := j + i]
            ifFalse: [j := ir + 1].
         ].
      self at: i put: d.
      ] ! !


Object subclass: #RandomNumber
instanceVariableNames: 'seed scale'
classVariableNames: 'Increment Multiplier Modulus FModulus'
poolDictionaries: ''
category: nil !

!RandomNumber class methodsFor: 'initialize'!

initialize
   Increment := 29573.
   Multiplier := 3877.
   Modulus := 139968.
   FModulus := 139968.0d ! !


!RandomNumber class methodsFor: 'instance creation'!

to: anInteger
   ^self basicNew to: anInteger ! !


!RandomNumber methodsFor: 'accessing'!

next
   seed := seed * Multiplier + Increment \\ Modulus.
     ^(seed * scale) asFloat / FModulus ! !

!RandomNumber methodsFor: 'private'!

to: anInteger
   seed := 42.
   scale := anInteger ! !


| n data randomNumber |
n := (Smalltalk arguments at: 1) asInteger.
data := Array new: n.
randomNumber := RandomNumber initialize; to: 1.0d.

1 to: n do: [:i| data at: i put: randomNumber next]. 
data heapsort.

(((data at: n) roundTo: 0.0000000001) asScaledDecimal: 10) displayNl !




