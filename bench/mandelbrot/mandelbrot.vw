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
   s := OS.Stdout.
   s nextPutAll: 'P4'; cr; nextPutAll: width printString, ' ', height printString; cr.

   0 to: height - 1 do: [:y|
      0 to: width - 1 do: [:x| | zr zi cr ci i |
         zr := 0.0d. zi := 0.0d.
         cr := 2.0d * x asDouble / width asDouble - 1.5d.
         ci := 2.0d * y asDouble / height asDouble - 1.0d.

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
            s nextPut: bits asCharacter.
            bits := 0. bitnum := 0.
            ].
         ].
      ].
   ^'' ! !
