"  The Great Computer Language Shootout
   contributed by Paolo Bonzini
   
   To run: gst -QI /usr/share/gnu-smalltalk/gst.im ary3.st -a 7000
"

| n x y |
n := Smalltalk arguments first asInteger.

x := (1 to: n) asArray.
y := Array new: n withAll: 0.

1000 timesRepeat: [ 
   n to: 1 by: -1 do: [:i| y at: i put: (y at: i) + (x at: i)] ].
   
(y at: 1) display. ' ' display. (y at: n) displayNl !