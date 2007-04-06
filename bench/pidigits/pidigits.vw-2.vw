"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy 
   modified by Eliot Miranda *"!

!Shootout.Tests class methodsFor: 'benchmark scripts'!

pidigits2
   self pidigitsTo: CEnvironment argv first asNumber width: 10 to: Stdout.
   ^'' ! !

!Shootout.Tests class methodsFor: 'benchmarks'!

pidigitsTo: v width: width to: output 
   | n i pidigits |
   n := v.
   i := 0.
   pidigits := PiDigitSpigot new.
   [n > 0] whileTrue:
      [n < width
         ifTrue:
            [n timesRepeat: [output nextPut: (Character digitValue: pidigits next)].
            n to: width do: [:each | output space].
            i := i + n]
         ifFalse:
            [width timesRepeat: [output nextPut: (Character digitValue: pidigits next)].
            i := i + width].
      output
         tab;
         nextPut: $:;
         print: i;
         cr.
      n := n - width] ! !


Smalltalk.Shootout defineClass: #PiDigitSpigot
   superclass: #{Core.Object}
   indexedType: #none
   private: false
   instanceVariableNames: 'z x inverse '
   classInstanceVariableNames: ''
   imports: ''
   category: 'Shootout'!


!Shootout.PiDigitSpigot class methodsFor: 'instance creation'!

new
   ^self basicNew initialize ! !


!Shootout.PiDigitSpigot methodsFor: 'initialize-release'!

initialize
   z := Transformation unity.
   x := Transformation new.
   inverse := Transformation new. ! !

!Shootout.PiDigitSpigot methodsFor: 'accessing'!

next
   | y |
   ^(self isSafe: (y := self digit))
      ifTrue: [z := self produce: y. y]
      ifFalse: [z := self consume: x next. self next] ! !

!Shootout.PiDigitSpigot methodsFor: 'private'!

consume: aTransformation
   ^z * aTransformation !

contentsSpecies
   ^ByteArray !

digit
   ^(z extract: 3) floor !

isSafe: aDigit
   ^aDigit = (z extract: 4) floor !

produce: anInteger
   inverse q: 10 r: -10 * anInteger s: 0 t: 1.
   ^inverse * z ! !


Smalltalk.Shootout defineClass: #Transformation
   superclass: #{Core.Object}
   indexedType: #none
   private: false
   instanceVariableNames: 'q r s t k '
   classInstanceVariableNames: ''
   imports: ''
   category: 'Shootout'!


!Shootout.Transformation class methodsFor: 'instance creation'!

new
   ^super new initialize!

q: anInteger1 r: anInteger2 s: anInteger3 t: anInteger4
   ^(super new) q: anInteger1 r: anInteger2 s: anInteger3 t: anInteger4 !

unity
   ^self q: 1 r: 0 s: 0 t: 1 ! !



!Shootout.Transformation methodsFor: 'initialize-release'!

initialize
   q := 0.
   r := 0.
   s := 0.
   t := 0.
   k := 0. ! !

!Shootout.Transformation methodsFor: 'accessing'!

* aTransformation
   ^self species
      q: q * aTransformation q
      r: q * aTransformation r + (r * aTransformation t)
      s: s * aTransformation q + (t * aTransformation s)
      t: s * aTransformation r + (t * aTransformation t) !

extract: anInteger
   ^(q * anInteger + r) // (s * anInteger + t) !

next
   k := k +1.
   q := k.
   r := 4 * k + 2.
   s := 0.
   t := 2 * k + 1. !

q
   ^q !

q: anInteger1 r: anInteger2 s: anInteger3 t: anInteger4
   q := anInteger1.
   r := anInteger2.
   s := anInteger3.
   t := anInteger4.
   k := 0. !

r
   ^r !

s
   ^s !

t
   ^t ! !
