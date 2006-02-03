REBOL [
	Title: "binary-trees"
	Author: "Robert Brandner"
]

node: make object! [
	left: none
	right: none
	item: none
]

check-item: func [n] [return either not n/left 
   [n/item][n/item + (check-item n/left) - (check-item n/right)]]

bottom-up: func [i depth /local n l r][
	either depth > 0 [l: bottom-up (2 * i - 1) (depth - 1)
					  r: bottom-up (2 * i) (depth - 1)
					  n: make node [left: l right: r item: i]]
					 [n: make node [item: i]]
	return n
]

n: either n: system/script/args [to integer! n] [4]
min-depth: 4
max-depth: max (min-depth + 2) n
stretch-depth: n + 1
stretched-tree: bottom-up 0 stretch-depth
print rejoin ["stretch tree of depth " stretch-depth "^- check: " check-item stretched-tree]
longlived-tree: bottom-up 0 n
for depth min-depth max-depth 2 [
	iterations: to-integer 2 ** (max-depth - depth + min-depth)
	check: 0
	repeat i iterations [
 		t: bottom-up i depth
		check: check + (check-item t)
 		t: bottom-up - i depth
		check: check + (check-item t)
	]
	print rejoin [2 * iterations "^- trees of depth " depth "^- check: " check]
]
print rejoin ["long lived tree of depth " n "^- check: " check-item longlived-tree]