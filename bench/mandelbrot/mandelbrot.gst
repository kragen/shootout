"  The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Isaac Gouy 

   To run: gst -QI /usr/share/gnu-smalltalk/gst.im mandelbrot.gst -a 200
"

| width height limit2 isOverLimit m bits bitnum s |
width := Smalltalk arguments first asInteger. 
height := width.
limit2 := 4.0. 
isOverLimit := False.
m := 50. 
bits := 0. 
bitnum := 0.
s := FileStream stdout bufferSize: 4096.
s nextPutAll: 'P4'; nl; nextPutAll: width printString, ' ', height printString; nl.

0 to: height - 1 do: [:y|
   0 to: width - 1 do: [:x| | zr zi cr ci i |
      zr := 0.0. zi := 0.0. 
      cr := 2.0 * x asFloat / width asFloat - 1.5.
      ci := 2.0 * y asFloat / height asFloat - 1.0.

      i := 0.
      [ | tr ti |
         tr := (zr*zr) - (zi*zi) + cr.
         ti := 2.0 * zr * zi + ci.
         zr := tr.
         zi := ti.
         isOverLimit := (zr*zr) + (zi*zi) > limit2.
         (isOverLimit not) and: [(i := i+1) < m]
      ] whileTrue.

      bits := bits bitShift: 1.
      (isOverLimit not) ifTrue: [bits := bits + 1]. 
      bitnum := bitnum + 1.

      (x = (width - 1)) ifTrue: [
         bits := bits bitShift: (8 - bitnum).
         bitnum := 8.
         ].

      (bitnum = 8) ifTrue: [
         s nextPutByte: bits.
         bits := 0. bitnum := 0.
         ].
      ].
   ] !
