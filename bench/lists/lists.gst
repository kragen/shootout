"  The Great Computer Language Shootout
   contributed by Isaac Gouy
 
   To run: gst -QI /usr/share/gnu-smalltalk/gst.im lists.st -a 16
"

| size n list1 list2 list3 count |
size := 10000.
n := Smalltalk arguments first asInteger.

n timesRepeat: [
   list1 := OrderedCollection new: size.
   1 to: size do: [:each| list1 addLast: each].
   list2 := list1 copy.

   list3 := OrderedCollection new: size.
   [list2 notEmpty] whileTrue: [list3 addLast: list2 removeFirst]. 
   [list3 notEmpty] whileTrue: [list2 addLast: list3 removeLast].

   list1 := list1 reverse. 
   count := (list1 first = size and: [list1 = list2]) 
      ifTrue: [list1 size] ifFalse: [-1].
   ].
   
count displayNl !
