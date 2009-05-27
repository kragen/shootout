"* The Computer Language Shootout
    http://shootout.alioth.debian.org/
    contributed by Paolo Bonzini *"!

Stream subclass: #PiDigitSpigot
    instanceVariableNames: 'numer accum denom k'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Shootout'!!PiDigitSpigot methodsFor: 'stream'!atEnd
    ^false!next
    | digit |
    [ self step. (digit := self extract) isNil ] whileTrue.
    self eliminate: digit.
    ^digit! !!PiDigitSpigot methodsFor: 'private'!initialize
    numer := denom := 1.
    k := accum := 0.!extract
    | tmp |
    numer > accum ifTrue: [ ^nil ].
    tmp := numer + numer + numer + accum.
    ^tmp \\ denom + numer < denom ifTrue: [ tmp // denom ] ifFalse: [ nil ]!eliminate: digit
    accum := accum - (denom * digit).
    accum := accum * 10.
    numer := numer * 10!step
    | y2 |
    k := k + 1.
    y2 := k * 2 + 1.
    accum := (numer + numer + accum) * y2.
    numer := numer * k.
    denom := denom * y2.! !!PiDigitSpigot class methodsFor: 'instance creation'!new   ^super basicNew initialize! !!Tests class methodsFor: 'benchmarking'!pidigits3To: v width: width to: output
   | n i pidigits |
   n := v.
   i := 0.
   pidigits := PiDigitSpigot new.
   [n > 0] whileTrue:
      [n < width
         ifTrue:
            [n timesRepeat: [output nextPut: (Character digitValue: pidigits next)].
            n to: width do: [:each | output space].
            i := i + n]
         ifFalse:
            [width timesRepeat: [output nextPut: (Character digitValue: pidigits next)].
            i := i + width].

      output tab; nextPut: $:; print: i; nl.

      n := n - width]! !!Tests class methodsFor: 'benchmark scripts'!pidigits3
   self pidigits3To: self arg width: 10 to: self stdout.
   ^''! !
