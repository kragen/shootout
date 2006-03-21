"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Paolo Bonzini
*"

| width height m bits s zr zi cr ci i tr stepr stepi |
width := Smalltalk arguments first asInteger.
height := width.
m := 50.
s := FileStream stdout bufferSize: 4096.
s nextPutAll: 'P4'; nl; nextPutAll: width printString, ' ', height 
printString; nl.

stepr := 2.0 / width.
stepi := 2.0 / height.

0 to: height - 1 do: [ :y |
    bits := 0.
    ci := stepi * y asFloat - 1.0.
    0 to: width - 1 do: [ :x |
        cr := stepr * x asFloat - 1.5.
        zr := cr. zi := ci.

        bits := bits bitShift: 1.
        i := 1.
        [
            tr := (zr*zr) - (zi*zi) + cr.
            zi := 2.0 * zr * zi + ci.
            zr := tr.
            (zr*zr) + (zi*zi) < 4.0 and: [ (i := i + 1) < m ]
        ] whileTrue.

        i = m ifTrue: [ bits := bits + 1 ].
        (x bitAnd: 7) == 7 ifTrue: [
            s nextPutByte: bits.
            bits := 0.
        ]
    ].
    (width bitAnd: 7) == 0 ifFalse: [
        bits := bits bitShift: 8 - (width bitAnd: 7).
        s nextPutByte: bits.
    ]
] !
