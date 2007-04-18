"* The Computer Language Shootout
    http://shootout.alioth.debian.org/
    contributed by Eliot Miranda *"!

!Tests class methodsFor: 'benchmarking'!mandelbrot: extent to: output   | limit2 isOverLimit bits bitnum |   limit2 := 4.0d0.   bits := bitnum := 0.   0 to: extent - 1 do:      [:y |      0 to: extent - 1 do:         [:x | | zr zi cr ci i |         zr := zi := 0.0d0.         cr := 2.0d0 * x / extent - 1.5d0.         ci := 2.0d0 * y / extent - 1.0d0.         i := 0.         [| tr ti |         tr := zr * zr - (zi * zi) + cr.         ti := 2.0d0 * zr * zi + ci.         zr := tr.         zi := ti.         (isOverLimit := zr * zr + (zi * zi) > limit2) or: [(i := i + 1) >= 50]]            whileFalse.         bits := bits + bits.         isOverLimit ifFalse: [bits := bits + 1].         bitnum := bitnum + 1.         x = (extent - 1) ifTrue:            [bits := bits bitShift: 8 - bitnum.            bitnum := 8].         bitnum = 8 ifTrue:            [output nextPutByte: bits.            bits := 0.            bitnum := 0]]]! !

!Tests class methodsFor: 'benchmark scripts'!mandelbrot   | n output |   n := self arg.   (output := self stdout)      nextPutAll: 'P4'; nl; print: n; space; print: n; nl.   self mandelbrot: n to: output.   ^''! !
