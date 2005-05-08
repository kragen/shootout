"  The Great Computer Language Shootout
   contributed by Isaac Gouy
   
   To run: gst -QI /usr/share/gnu-smalltalk/gst.im wc.st < input.txt
"

| newline space tab nl nw nc insideWord stream ch |

newline  := Character nl.
space := Character space.
tab := Character tab.

nl := nw := nc := 0.
insideWord := false.
stream := FileStream stdin bufferSize: 4096.

[(ch := stream next) notNil] whileTrue: [
   nc := nc + 1.
   ch = newline ifTrue: [nl := nl + 1].
   (ch = space or: [ch = newline or: [ch = tab]])
      ifTrue: [insideWord := false]
      ifFalse: [
         insideWord ifFalse: [
            insideWord := true. 
            nw := nw + 1
         ].
      ].
].      

Transcript 
   show: nl displayString; space;
   show: nw displayString; space;
   show: nc displayString; nl !
   