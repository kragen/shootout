"  The Great Computer Language Shootout
   contributed by Paolo Bonzini
   
   To run: gst -QI /usr/share/gnu-smalltalk/gst.im matrix.st -a 300
"

!Array class methodsFor: 'instance creation'!

newMatrix: rows columns: cols
   | count mx row |
   count := 1.
   mx := self new: rows.
   1 to: rows do: [ :i |
      row := mx at: i put: (Array new: cols).
      1 to: cols do: [ :j |
         row at: j put: count.
         count := count + 1
      ].
   ].
   ^mx! !
    
!Array methodsFor: 'testing'!

atXY: coord
   ^(self at: coord x) at: coord y!
    
mmult: m2
   | rows cols terms val mx row myRow |
   rows := self size.
   terms := m2 size.
   cols := m2 first size.
   mx := Array new: rows.
   1 to: rows do: [ :i |
      row := mx at: i put: (Array new: cols).
      myRow := self at: i.
      1 to: cols do: [ :j |
         val := 0.
         1 to: terms do: [ :k |
            val := val + ((myRow at: k) * ((m2 at: k) at: j) bitAnd: 16r3FFF_FFFF) ].
         row at: j put: val.
      ].
   ].
   ^mx! !
    
    
| m1 m2 mm size n |
n := Smalltalk arguments isEmpty
   ifTrue: [ 1 ]
   ifFalse: [ 1 max: Smalltalk arguments first asInteger ].
   
size := 30.
m1 := Array newMatrix: size columns: size.
m2 := Array newMatrix: size columns: size.
n timesRepeat: [ mm := m1 mmult: m2 ].

('%1 %2 %3 %4' bindWith: (mm atXY: 1@1)
   with: (mm atXY: 3@4) with: (mm atXY: 4@3)
   with: (mm atXY: 5@5)) displayNl!
    