REBOL [
	Title: "fannkuch"
	Author: "Robert Brandner"
]

n: either n: system/script/args [to integer! n] [7]

times-rotated: make block! n
insert/dup times-rotated 0 n
perm: make block! n
repeat i n [append perm i]

next-permutation: does [
	for r 2 n 1 [
		; rotate the first r items to the left
		temp: pick perm 1
		for i 1 (r - 1) 1 [poke perm i (pick perm (i + 1))]
		poke perm r temp
		poke times-rotated r ((pick times-rotated r) + 1)
		reminder: (pick times-rotated r) // r
		if reminder <> 0 [return perm]
	]
	return none
]

count-flips: does [
	pk: copy perm
	cnt: 0
	while [pk/1 <> 1][
		reverse/part pk pk/1
		cnt: cnt + 1
	]
	return cnt
]

mx: 0
show: 0
while [perm] [
	if (show < 30) [print rejoin perm show: show + 1]
	mx: max mx count-flips
	perm: next-permutation
]
print rejoin ["Pfannkuchen(" n ") = " mx]
