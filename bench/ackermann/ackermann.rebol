The Computer Language Shootout http://shootout.alioth.debian.org/

REBOL [Title: "ackermann" Date: 21-Jun-2003 Author: "Isaac Gouy (Rebol novice)"]

; get the command line arg
argN: does [
   n: to-integer system/script/args
   either n > 0 [n] [1]
   ]



n: argN

ack: func [m n][
   if m = 0 [return n + 1]
   if n = 0 [return ack (m - 1) 1]
   return ack (m - 1) (ack m (n - 1)) 
   ]

print rejoin ["Ack(3," n "): " ack 3 n] 