"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Eliot Miranda *"!


Smalltalk.Shootout defineClass: #Tests
   superclass: #{Core.Object}
   indexedType: #none
   private: false
   instanceVariableNames: ''
   classInstanceVariableNames: ''
   imports: ''
   category: 'ComputerLanguageShootout' !

!Shootout.Tests class methodsFor: 'benchmarking'!

mandelbrot2
   | n |
   n := CEnvironment argv first asNumber.
   Stdout nextPutAll: 'P4'; cr; print: n; space; print: n; cr.
   Stdout binary.
   self mandelbrot2: n to: Stdout.
   Stdout flush.
   ^'' ! !

!Shootout.Tests class methodsFor: 'benchmarks'!

mandelbrot2: extent to: output 
   | limit2 isOverLimit bits bitnum |
   limit2 := 4.0d.
   bits := bitnum := 0.
   0 to: extent - 1 do:
      [:y | 
      0 to: extent - 1 do:
         [:x | | zr zi cr ci i |
         zr := zi := 0.0d.
         cr := 2.0d * x / extent - 1.5d.
         ci := 2.0d * y / extent - 1.0d.
         i := 0.
         
         [| tr ti |
         tr := zr * zr - (zi * zi) + cr.
         ti := 2.0d * zr * zi + ci.
         zr := tr.
         zi := ti.
         (isOverLimit := zr * zr + (zi * zi) > limit2) or: [(i := i + 1) >= 50]]
            whileFalse.
         bits := bits + bits.
         isOverLimit ifFalse: [bits := bits + 1].
         bitnum := bitnum + 1.
         x = (extent - 1) ifTrue:
            [bits := bits bitShift: 8 - bitnum.
            bitnum := 8].
         bitnum = 8 ifTrue:
            [output nextPut: bits.
            bits := 0.
            bitnum := 0]]] ! !
