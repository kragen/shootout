The Computer Language Shootout http://shootout.alioth.debian.org/

Reads the whole file at once, should only do 4k

REBOL [Title: "sumcol" Date: 22-Jun-2003 Author: "Isaac Gouy (Rebol novice)"]

sum: 0
lines: copy system/ports/input
forall lines [sum: sum + to-integer first lines]
print sum