"  The Great Computer Language Shootout
   contributed by Isaac Gouy (improved by Paolo Bonzini)
   
   To run: gst -QI /usr/share/gnu-smalltalk/gst.im heapsort.st -a 80000
"

!Array methodsFor: 'sorting'!

heapsort
   | j i ir l r |
   ir := self size.
   l := self size // 2 + 1.  
   
   [
      l > 1 
         ifTrue: [ r := self at: (l := l - 1)]
         ifFalse: [
            r := self at: ir.
            self at: ir put: (self at: 1).
            ir := ir - 1.
            ir = 1 ifTrue: [self at: 1 put: r. ^self] ]. 
                
      i := l.
      j := l * 2.
      [j <= ir] whileTrue: [
         (j < ir and: [(self at: j) < (self at: j + 1)]) 
            ifTrue: [j := j + 1].
          
         r < (self at: j)
            ifTrue: [self at: i put: (self at: j). i := j. j := j + i]
            ifFalse: [j := ir + 1].
      ].
      self at: i put: r.   
   ] repeat ! !


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
   ^(seed * scale) asFloatD / FModulus ! !
     
!RandomNumber methodsFor: 'private'!

to: anInteger
   seed := 42.
   scale := anInteger ! !
   
   
!Float methodsFor: 'printing'!

printStringRoundedTo: anInteger
   | s |
   s := (0.5d * (10 raisedToInteger: anInteger negated) + self) printString.
   ^s copyFrom: 1 to: (s indexOf: $.) + anInteger ! !  
   
   
| n data randomNumber |
n := Smalltalk arguments first asInteger.
data := Array new: n.
randomNumber := RandomNumber initialize; to: 1.
1 to: n do: [:i| data at: i put: randomNumber next]. 
data heapsort.
(data last printStringRoundedTo: 10) displayNl !
