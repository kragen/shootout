
REBOL [
  Title: partialsums
  Name: {The Great Computer Language Shootout}
  Home: {http://shootout.alioth.debian.org/}
  Author: {Anthony Borla}
  Date: 2006-03-03
  Version: 1.0
  Notes: {Based on D language version by Dave Fladebo}
]

; -------------

a1: a2: a3: a4: a5: a6: a7: a8: a9: 0.0

; -------------

computeSums: func [n /local d d2 d3 ds dc alt] [
  alt: 1.0

  repeat d n [
    d2: d * d
    d3: d2 * d
    ds: sine d
    dc: cosine d

    a1: a1 + ((2.0 / 3.0) ** (d - 1.0))
    a2: a2 + (1.0 / (square-root d))
    a3: a3 + (1.0 / (d * (d + 1.0)))

    a4: a4 + (1.0 / (d3 * ds * ds))
    a5: a5 + (1.0 / (d3 * dc * dc))
    a6: a6 + (1.0 / d)

    a7: a7 + (1.0 / d2)
    a8: a8 + (alt / d)
    a9: a9 + (alt / ((2.0 * d) - 1.0))

    alt: -(alt)
  ]
]

; -------------

showSums: func [] [
  print rejoin [round/to a1 0.000000001 "^-(2/3)^^k"]
  print rejoin [round/to a2 0.000000001 "^-k^^-0.5"]
  print rejoin [round/to a3 0.000000001 "^-1/k(k+1)"]
  print rejoin [round/to a4 0.000000001 "^-Flint Hills"]
  print rejoin [round/to a5 0.000000001 "^-Cookson Hills"]
  print rejoin [round/to a6 0.000000001 "^-Harmonic"]
  print rejoin [round/to a7 0.000000001 "^-Riemann Zeta"]
  print rejoin [round/to a8 0.000000001 "^-Alternating Harmonic"]
  print rejoin [round/to a9 0.000000001 "^-Gregory"]
]

; -------------

N: either N: system/script/args [to-integer N][1]

computeSums N
showSums

quit/return 0

