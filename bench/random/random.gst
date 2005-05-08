"  The Great Computer Language Shootout
   contributed by Isaac Gouy
   
   To run: gst -QI /usr/share/gnu-smalltalk/gst.im random.st -a 900000
"

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
   FModulus := 139968.0d.     
! !

!RandomNumber class methodsFor: 'instance creation'!

to: anInteger
   ^self basicNew to: anInteger ! !
   
!RandomNumber methodsFor: 'accessing'!

next
   seed := seed * Multiplier + Increment \\ Modulus.
   ^(seed * scale) asFloatD / FModulus ! !
     
!RandomNumber methodsFor: 'private'!

to: anInteger
   seed := 42.
   scale := anInteger ! !
   
   
!Float methodsFor: 'printing'!

printStringRoundedTo: anInteger
   | n s |
   n := 0.5d * (10 raisedToInteger: anInteger negated).
   s := ((self sign < 0) ifTrue: [self - n] ifFalse: [self + n]) printString.
   ^s copyFrom: 1 to: (s indexOf: $.) + anInteger ! !  
   
   
| n random x |
n := Smalltalk arguments first asInteger.

random := RandomNumber initialize; to: 100.
n timesRepeat: [x := random next].
(x printStringRoundedTo: 9) displayNl !
