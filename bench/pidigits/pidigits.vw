"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy"!

!ComputerLanguageShootout.Benchmarks class methodsFor: 'benchmarking'!

pidigits: argvString
   | i length n pidigits stream |
   n := argvString asNumber.
   i := 0.
   length := 10.
   pidigits := PiDigitSpigot new.

   stream := ReadWriteStream on: (String new: 30).

   [n > 0] whileTrue: [

      (n < length)  
         ifTrue: [
            n timesRepeat: [
               stream nextPut: (Character digitValue: pidigits next)
               ].

            n to: length do: [:each| stream space]. 
            i := i + n.
            ] 

         ifFalse: [
            length timesRepeat: [
               stream nextPut: (Character digitValue: pidigits next)
               ].

            i := i + length.
            ].

     stream tab nextPut: $:.
      i printOn: stream. 
      stream cr.

      OS.Stdout nextPutAll: stream contents.
      stream reset.
      n := n - length.
   ]! !


Smalltalk.ComputerLanguageShootout defineClass: #PiDigitSpigot
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'z x inverse '
	classInstanceVariableNames: ''
	imports: ''
	category: 'ComputerLanguageShootout'!


!ComputerLanguageShootout.PiDigitSpigot class methodsFor: 'instance creation'!

new
   ^super new initialize! !


!ComputerLanguageShootout.PiDigitSpigot methodsFor: 'initialize-release'!

initialize
   z := Transformation unity.
   x := Transformation new.
   inverse := Transformation new.! !

!ComputerLanguageShootout.PiDigitSpigot methodsFor: 'accessing'!

next
   | y |
   ^(self isSafe: (y := self digit))
      ifTrue: [z := self produce: y. y]
      ifFalse: [z := self consume: x next. self next]! !

!ComputerLanguageShootout.PiDigitSpigot methodsFor: 'private'!

consume: aTransformation
   ^z * aTransformation!

digit
   ^(z extract: 3) floor!

isSafe: aDigit
   ^aDigit = (z extract: 4) floor!

produce: anInteger
   inverse q: 10 r: -10 * anInteger s: 0 t: 1.
   ^inverse * z! !


Smalltalk.ComputerLanguageShootout defineClass: #Transformation
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'q r s t k '
	classInstanceVariableNames: ''
	imports: ''
	category: 'ComputerLanguageShootout'!


!ComputerLanguageShootout.Transformation class methodsFor: 'instance creation'!

new
   ^super new initialize!

q: anInteger1 r: anInteger2 s: anInteger3 t: anInteger4
   ^(super new) q: anInteger1 r: anInteger2 s: anInteger3 t: anInteger4!

unity
   ^self q: 1 r: 0 s: 0 t: 1! !



!ComputerLanguageShootout.Transformation methodsFor: 'initialize-release'!

initialize
   q := 0.
   r := 0.
   s := 0.
   t := 0.
   k := 0.! !

!ComputerLanguageShootout.Transformation methodsFor: 'accessing'!

* aTransformation
   ^self species 
      q: q * aTransformation q
      r: q * aTransformation r + (r * aTransformation t)
      s: s * aTransformation q + (t * aTransformation s)
      t: s * aTransformation r + (t * aTransformation t)!

extract: anInteger
   ^(q * anInteger + r) // (s * anInteger + t)!

next
   k := k +1.
   q := k.
   r := 4 * k + 2.
   s := 0.
   t := 2 * k + 1.!

q
   ^q!

q: anInteger1 r: anInteger2 s: anInteger3 t: anInteger4
   q := anInteger1.
   r := anInteger2.
   s := anInteger3.
   t := anInteger4.
   k := 0.!

r
   ^r!

s
   ^s!

t
   ^t! !
