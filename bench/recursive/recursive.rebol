
REBOL [
  Title: recursive
  Name: {The Great Computer Language Shootout}
  Home: {http://shootout.alioth.debian.org/}
  Author: {Anthony Borla}
  Date: 2006-02-27
  Version: 1.1
  Notes: {Code based on / inspired by existing, relevant Shootout submissions}
]

; -------------

ack: func [x y] [
  if x == 0 [return y + 1]
  if y == 0 [return (ack x - 1 1)]
  return (ack x - 1 (ack x y - 1))
]

; -------------

fib: func [n] [
  if n < 2 [return 1]
  return (fib n - 2) + (fib n - 1)
]

; -------------

tak: func [x y z] [
  if y < x [return (tak (tak x - 1.0 y z) (tak y - 1.0 z x) (tak z - 1.0 x y))]
  return z
]

; -------------

N: either N: system/script/args [to-integer N][1]

print rejoin ["Ack(3," N "): " (ack 3 N)]
print rejoin ["Fib(" (27.0 + N) "): " round/to (fib 27.0 + N) 0.1]

N: N - 1
print rejoin ["Tak(" (N * 3) "," (N * 2) "," N "): " round/to (tak N * 3 N * 2 N) 1]

print rejoin ["Fib(3): " (fib 3)]
print rejoin ["Tak(3.0,2.0,1.0): " round/to (tak 3.0 2.0 1.0) 0.1]

quit/return 0

