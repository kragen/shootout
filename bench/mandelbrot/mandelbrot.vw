"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Paolo Bonzini"!

!ComputerLanguageShootout.Benchmarks class methodsFor: 'benchmarking'!

mandelbrot: argvString
   | width height limit2 isOverLimit m bits bitnum s |
   width := argvString asNumber.
   height := width.
   limit2 := 4.0.
   isOverLimit := False.
   m := 50.
   bits := 0.
   bitnum := 0.
   s := OS.Stdout.
   s nextPutAll: 'P4'; cr; nextPutAll: width printString, ' ', height printString; cr.

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
            s nextPut: (Character value: bits).
            bits := 0. bitnum := 0.
            ].
         ].
      ]! !
