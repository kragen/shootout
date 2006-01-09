
rebol [
  Title: harmonic
  Name: {The Great Computer Language Shootout}
  Home: {http://shootout.alioth.debian.org/}
  Author: {Anthony Borla}
  Date: 2005-12-31
  Version: 1.0
]

; -------------

harmonic: func [n /local sum] [
  sum: 0.0
  repeat i n [sum: sum + (1 / i)]
  sum
]

; -------------

N: either N: system/script/args [to-integer N][1]

print round/to harmonic N 0.000000001
