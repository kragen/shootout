"  The Great Computer Language Shootout
   contributed by Isaac Gouy

   To run: gst -Q random.st -a 900000
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
     ^(seed * scale) asFloat / FModulus ! !

!RandomNumber methodsFor: 'private'!

to: anInteger
   seed := 42.
   scale := anInteger ! !


| n random x |
n := (Smalltalk arguments at: 1) asInteger.

random := RandomNumber initialize; to: 100.
n timesRepeat: [x := random next].
(x asScaledDecimal: 9) displayNl !