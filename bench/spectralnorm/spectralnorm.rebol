
REBOL [
  Title: spectralnorm
  Name: {The Great Computer Language Shootout}
  Home: {http://shootout.alioth.debian.org/}
  Author: {Anthony Borla}
  Date: 2006-05-04
  Version: 1.0
]

; -----------------------------

approximate: func [n /local u v vBv vV] [
  u: make block! n
  insert/dup u 1.0 n

  v: make block! n
  insert/dup v 0.0 n

  vBv: vV: 0.0

  loop 10 [
    mulAtAv n u v
    mulAtAv n v u
  ]

  repeat i n [
    vBv: vBv + ((pick u i) * (pick v i))
    vV: vV + ((pick v i) * (pick v i))
  ]

  return square-root (vBv / vV)
]

; -------------

A: func [i j] [
  i: i - 1
  j: j - 1
  return 1.0 / ((((i + j) * ( i + j + 1.0)) / 2.0) + i + 1.0)
]

; -------------

mulAv: func [n v av] [
  repeat i n [
    poke av i 0.0
    repeat j n [
      poke av i ((pick av i) + ((A i j) * (pick v j)))
    ]
  ]
]

; -------------

mulAtV: func [n v atv] [
  repeat i n [
    poke atv i 0.0
    repeat j n [
      poke atv i ((pick atv i) + ((A j i) * (pick v j)))
    ]
  ]
]

; -------------

mulAtAv: func [n v atav /local u] [
  u: make block! n
  insert/dup u 0.0 n
  mulAv n v u
  mulAtV n u atav
]

; -----------------------------

N: either N: system/script/args [to-integer N][1]

print round/to (approximate N) 0.000000001

quit/return 0

