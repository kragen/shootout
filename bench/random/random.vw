"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy"!

!Shootout.Tests class methodsFor: 'benchmarking'!

random
   | n random answer |
   n := CEnvironment argv first asNumber.
   random := RandomNumber to: 100.
   n timesRepeat: [answer := random next].
   ^(answer asStringWith: 9) withNl ! !


Smalltalk.Shootout defineClass: #RandomNumber
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'seed scale '
	classInstanceVariableNames: ''
	imports: ''
	category: 'Shootout'!

Shootout.RandomNumber defineSharedVariable: #Modulus
	private: false
	constant: false
	category: 'computer language shootout'
	initializer: '139968'!

#{Shootout.RandomNumber.Modulus} initialize!

Shootout.RandomNumber defineSharedVariable: #FModulus
	private: false
	constant: false
	category: 'computer language shootout'
	initializer: '139968.0d'!

#{Shootout.RandomNumber.FModulus} initialize!

Shootout.RandomNumber defineSharedVariable: #Multiplier
	private: false
	constant: false
	category: 'computer language shootout'
	initializer: '3877'!

#{Shootout.RandomNumber.Multiplier} initialize!

Shootout.RandomNumber defineSharedVariable: #Increment
	private: false
	constant: false
	category: 'computer language shootout'
	initializer: '29573'!

#{Shootout.RandomNumber.Increment} initialize!


!Shootout.RandomNumber class methodsFor: 'instance creation'!

to: anInteger
   ^self basicNew to: anInteger ! !


!Shootout.RandomNumber methodsFor: 'accessing'!

next
	seed := (seed * Multiplier + Increment) \\ Modulus.
	^(seed * scale) asDouble / FModulus ! !

!Shootout.RandomNumber methodsFor: 'private'!

to: anInteger
   seed := 42.
   scale := anInteger ! !
