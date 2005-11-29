"  The Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Paolo Bonzini
   would have never gotten the permutation right without Isaac Gouy's program "

Object subclass: #PermGenerator
	instanceVariableNames: 'count perm atEnd'
	classVariableNames: ''
	poolDictionaries: ''
	category: nil!

!PermGenerator class methodsFor: 'create'!

new: size
    ^self new
	initialize: size;
	yourself! !

!PermGenerator methodsFor: 'create'!

atEnd
    ^atEnd!

next
    | result size temp i j r remainder |
    result := perm copy.

    "Generate the next permutation."
    size := perm size.
    r := 2.
    [
        temp := perm at: 1.
        1 to: r - 1 do: [ :i |
            perm at: i put: (perm at: i + 1) ].
        perm at: r put: temp.

        remainder := count at: r put: (count at: r) - 1.
        remainder == 1 and: [ (r := r + 1) <= size ]
    ] whileTrue.
    atEnd := r > size.

    "compiler bug in gst 2.2?"
    "1 to: r - 1 do: [ :i |
	count at: r put: r + 1 ]."

    [ (r := r - 1) >= 1 ] whileTrue: [
        count at: r put: r + 1 ].
    ^result!

initialize: size
    perm := (1 to: size) asArray.
    count := (2 to: size + 1) asArray.
    atEnd := false! !

!Array methodsFor: 'pfannkuchen'!

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

!Integer methodsFor: 'pfannkuchen'!

maxPfannkuchen
    | max gen perm check |
    max := 0.
    check := 0.
    gen := PermGenerator new: self.
    [ gen atEnd ] whileFalse: [
	perm := gen next.
        check < 30 ifTrue: [
	    perm do: [ :each | each print ].
	    Transcript nl.
	    check := check + 1 ].
	max := max max: perm pfannkuchen
    ].
    ^max! !

| n |
n := Smalltalk arguments first asInteger.
Transcript
    show: ('Pfannkuchen(%1) = %2' bindWith: n with: n maxPfannkuchen);
    nl!
