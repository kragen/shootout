"  The Great Computer Language Shootout
   contributed by Isaac Gouy

   To run: gst -Q hash2.st -a 150
"

| n table1 table2 buffer |
n := (Smalltalk arguments at: 1) asInteger.

table1 := Dictionary new: 12000. 
table2 := Dictionary new: n + (n // 5).

buffer := WriteStream on: (String new: 10).
0 to: 9999 do: [:i| | foo |
   buffer nextPutAll: 'foo_'.
   i printOn: buffer.
   foo := buffer contents.
   buffer reset.
   table1 at: foo put: i.
]. 


n timesRepeat: [ 
   table1 keysAndValuesDo: [ :key :value |  | assoc |
      (assoc := table2 associationAt: key ifAbsent: []) isNil 
         ifTrue: [table2 at: key put: value]
         ifFalse: [assoc value: assoc value + value]   
   ]
]. 

(table1 at: 'foo_1')    display. ' ' display. 
(table1 at: 'foo_9999') display. ' ' display.
(table2 at: 'foo_1')    display. ' ' display. 
(table2 at: 'foo_9999') displayNl !