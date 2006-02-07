"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Paolo Bonzini"!

!Shootout.Tests class methodsFor: 'benchmarking'!

mandelbrot
   | width height limit2 isOverLimit m bits bitnum s |
   width := CEnvironment argv first asNumber.
   height := width.
   limit2 := 4.0d.
   isOverLimit := False.
   m := 50.
   bits := 0.
   bitnum := 0.
   s := ExternalWriteStream on: 
      (ExternalConnection ioAccessor: (UnixDiskFileAccessor new handle: 1)).
   s nextPutAll: 'P4'; cr; nextPutAll: width printString, ' ', height printString; cr.

   width := width asDouble. height := height  asDouble.
   0.0d to: height - 1.0d  do: [:y|
      0.0d to: width - 1.0d do: [:x| | zr zi cr ci i |
         zr := 0.0d. zi := 0.0d.
         cr := 2.0d * x / width - 1.5d.
         ci := 2.0d * y / height - 1.0d.

         i := 0.
         [ | tr ti |
            tr := (zr*zr) - (zi*zi) + cr.
            ti := 2.0d * zr * zi + ci.
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
            s nextPut: bits asCharacter.
            bits := 0. bitnum := 0.
            ].
         ].
      ].
   s flush.
   ^'' ! !
