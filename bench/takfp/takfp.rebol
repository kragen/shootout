
rebol [
  Title: takfp
  Name: {The Computer Language Shootout}
  Home: {http://shootout.alioth.debian.org/}
  Author: {Anthony Borla}
  Date: 2005-12-31
  Version: 1.0
]

; -------------

tak: func [x y z] [either y >= x [z][tak tak x - 1.0 y z tak y - 1.0 z x tak z - 1.0 x y]]

; -------------

N: either N: system/script/args [to-integer N][1]
print tak N * 3.0 N * 2.0 N * 1.0
