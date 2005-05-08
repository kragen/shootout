"  The Great Computer Language Shootout
   contributed by Isaac Gouy (with improvements by Paolo Bonzini)
   
   To run: gst -QI /usr/share/gnu-smalltalk/gst.im hash2.st -a 150
"

| n table1 table2 |
n := Smalltalk arguments first asInteger.

table1 := Dictionary new: 12000. 
table2 := Dictionary new: n + (n // 5).

0 to: 9999 do: [:each| table1 at: 'foo_', each printString put: each].

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
