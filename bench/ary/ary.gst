"  The Great Computer Language Shootout
   contributed by Isaac Gouy

   To run: gst -Q ary.st -a 7000
"

| n x y |
n := (Smalltalk arguments at: 1) asInteger.

x := WordArray new: n.
y := WordArray new: n withAll: 0.
1 to: n do: [:i| x at: i put: i ].

1 to: 1000 do: [:k| 
   n to: 1 by: -1 do: [:i| y at: i put: (y at: i) + (x at: i)] ].

(y at: 1) display. ' ' display. (y at: n) displayNl !
