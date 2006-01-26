REBOL [
	Title: "sieve of eratosthenes"
	File: %sieve.r
	Version: 0.2
	Author: "Robert Brandner"
	Date: 26-January-2006
]

n: either n: system/script/args [to integer! n] [2]

sieve: func [m] [
	prim: make block! m
	insert/dup prim true m
	head prim
	cnt: 0
	for i 2 m 1 [
		if (pick prim i) [
			cnt: cnt + 1
			for k (i + i) m i [
				poke prim k false
			]
		]
	]
	return cnt
]

; couldn't find something like printf in rebol ...
pretty: func [n] [
	str: make string! 8
	insert/dup str " " (8 - (length? to-string n))
	append str n
]

m: to-integer (2 ** n) * 10000
print ["Primes up to" pretty m pretty sieve m]
m: to-integer (2 ** (n - 1)) * 10000
print ["Primes up to" pretty m pretty sieve m]
m: to-integer (2 ** (n - 2)) * 10000
print ["Primes up to" pretty m pretty sieve m]
