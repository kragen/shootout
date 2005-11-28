"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy"!

!ComputerLanguageShootout.Benchmarks class methodsFor: 'benchmarking'!

random: argvString 
   | n random answer |
   n := argvString asNumber.
   random := RandomNumber to: 100.
   n timesRepeat: [answer := random next].
   OS.Stdout nextPutAll: ((answer asFixedPoint: 9) printString copyWithout: $s); cr! !


Smalltalk.ComputerLanguageShootout defineClass: #RandomNumber
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'seed scale '
	classInstanceVariableNames: ''
	imports: ''
	category: 'ComputerLanguageShootout'!

ComputerLanguageShootout.RandomNumber defineSharedVariable: #Modulus
	private: false
	constant: false
	category: 'computer language shootout'
	initializer: '139968'!

#{ComputerLanguageShootout.RandomNumber.Modulus} initialize!

ComputerLanguageShootout.RandomNumber defineSharedVariable: #FModulus
	private: false
	constant: false
	category: 'computer language shootout'
	initializer: '139968.0d'!

#{ComputerLanguageShootout.RandomNumber.FModulus} initialize!

ComputerLanguageShootout.RandomNumber defineSharedVariable: #Multiplier
	private: false
	constant: false
	category: 'computer language shootout'
	initializer: '3877'!

#{ComputerLanguageShootout.RandomNumber.Multiplier} initialize!

ComputerLanguageShootout.RandomNumber defineSharedVariable: #Increment
	private: false
	constant: false
	category: 'computer language shootout'
	initializer: '29573'!

#{ComputerLanguageShootout.RandomNumber.Increment} initialize!


!ComputerLanguageShootout.RandomNumber class methodsFor: 'instance creation'!

to: anInteger
   ^self basicNew to: anInteger! !


!ComputerLanguageShootout.RandomNumber methodsFor: 'accessing'!

next
	seed := (seed * Multiplier + Increment) \\ Modulus.
	^(seed * scale) asDouble / FModulus! !

!ComputerLanguageShootout.RandomNumber methodsFor: 'private'!

to: anInteger
   seed := 42.
   scale := anInteger! !
