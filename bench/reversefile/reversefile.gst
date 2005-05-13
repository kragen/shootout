"  The Great Computer Language Shootout
   contributed by Paolo Bonzini 
   
   To run: gst -QI /usr/share/gnu-smalltalk/gst.im reversefile < input.txt 
"

| s last out ptr |
s := (FileStream stdin bufferSize: 4096) contents.
last := s size.
out := String new: s size.
ptr := 1.

s size - 1 to: 1 by: -1 do: [ :i |
   (s at: i) == ##(Character nl) ifTrue: [
      out
         replaceFrom: ptr
         to: ptr + (last - i - 1)
         with: s
         startingAt: i + 1.

      ptr := ptr + last - i.
      last := i.
   ]
].

out
   replaceFrom: ptr
   to: out size
   with: s
   startingAt: 1.
   
stdout nextPutAll: out !
