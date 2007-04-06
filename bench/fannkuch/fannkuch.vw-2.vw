"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Paolo Bonzini *"!


Smalltalk.Shootout defineClass: #Tests
   superclass: #{Core.Object}
   indexedType: #none
   private: false
   instanceVariableNames: ''
   classInstanceVariableNames: ''
   imports: ''
   category: 'ComputerLanguageShootout' !

!Shootout.Tests class methodsFor: 'benchmark scripts'!

fannkuch2
	| n |
	n := CEnvironment argv first asNumber.
	^'Pfannkuchen(', n printString, ') = ', 
           (self fannkuch: n to: Stdout) printString withNl ! !

!Shootout.Tests class methodsFor: 'benchmarks'!

fannkuch: n to: output
   ^(PermGenerator new: n) maxPfannkuchenTo: output ! !


Smalltalk.Shootout defineClass: #PermGenerator
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'timesRotated perm atEnd '
	classInstanceVariableNames: ''
	imports: ''
	category: 'Shootout'!

!Shootout.PermGenerator class methodsFor: 'instance creation'!

new: size
    ^self new
	initialize: size;
	yourself ! !

!Shootout.PermGenerator methodsFor: 'initialize-release'!

initialize: size
    perm := (1 to: size) asArray.
    timesRotated := Array new: size withAll: 0.
    atEnd := false ! !

!Shootout.PermGenerator methodsFor: 'private'!

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
    atEnd := true ! !

!Shootout.PermGenerator methodsFor: 'accessing'!

atEnd
    ^atEnd !

next
    | result |
    result := perm copy.
    self makeNext.
    ^result ! !

!Shootout.PermGenerator methodsFor: 'benchmarks'!

maxPfannkuchenTo: output 
	| max permutation check |
	max := 0.
	check := 0.
	[self atEnd] whileFalse:
		[permutation := self next.
		check < 30 ifTrue:
			[permutation do: [:each | output print: each].
			output cr.
			check := check + 1].
		max := max max: permutation pfannkuchen].
	^max ! !

!Core.Array methodsFor: 'computer language shootout'!

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
    ^k ! !


