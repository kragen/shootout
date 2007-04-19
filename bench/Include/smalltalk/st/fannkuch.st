"* The Computer Language Shootout
    http://shootout.alioth.debian.org/
    contributed by Paolo Bonzini *"!


Object subclass: #PermGenerator
   instanceVariableNames: 'timesRotated perm atEnd'
   classVariableNames: ''
   poolDictionaries: ''
   category: 'Shootout'!


!Array methodsFor: 'benchmarking'!
pfannkuchen
   | first complement a b k |
   k := 0.
   [ (first := self at: 1) == 1 ] whileFalse: [
      k := k + 1.
      complement := first + 1.
      1 to: first // 2 do: [ :i |
         a := self at: i.
         b := self at: complement - i.
         self at: i put: b.
         self at: complement - i put: a.
      ]
   ].
   ^k! !



!PermGenerator methodsFor: 'initialize-release'!
initialize: size
   perm := (1 to: size) asArray.
   timesRotated := Array new: size withAll: 0.
   atEnd := false! !



!PermGenerator methodsFor: 'initialize-release'!
makeNext
   | temp remainder |
   "* Generate the next permutation. *"
   2 to: perm size do: [ :r |
      "* Rotate the first r items to the left. *"
      temp := perm at: 1.
      1 to: r - 1 do: [ :i | perm at: i put: (perm at: i + 1) ].
      perm at: r put: temp.

      remainder := timesRotated at: r put: ((timesRotated at: r) + 1) \\ r.
      remainder = 0 ifFalse: [ ^self ].

      "* After r rotations, the first r items are in their original positions.
      Go on rotating the first r+1 items. *"
   ].

   "* We are past the final permutation. *"
   atEnd := true! !



!PermGenerator methodsFor: 'benchmarks'!
maxPfannkuchenTo: output
   | max permutation check |
   max := 0.
   check := 0.
   [self atEnd] whileFalse:
      [permutation := self next.
      check < 30 ifTrue:
         [permutation do: [:each | output print: each].
         output nl.
         check := check + 1].
      max := max max: permutation pfannkuchen].
   ^max! !



!PermGenerator methodsFor: 'accessing'!
atEnd
   ^atEnd! !



!PermGenerator methodsFor: 'accessing'!
next
   | result |
   result := perm copy.
   self makeNext.
   ^result! !



!PermGenerator class methodsFor: 'instance creation'!
new: size
   ^self new
      initialize: size;
      yourself! !



!Tests class methodsFor: 'benchmarking'!
fannkuch: n to: output
   ^(PermGenerator new: n) maxPfannkuchenTo: output! !



!Tests class methodsFor: 'benchmark scripts'!
fannkuch
   | n f |
   n := self arg.
   f := self fannkuch: n to: self stdout.
   self stdout
      nextPutAll: 'Pfannkuchen(', n printString, ') = ';
      print: f; nl.
   ^''! !
