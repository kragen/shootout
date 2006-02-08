REBOL [Title: "reverse complement" Author: "Robert Brandner"]

rev-compl: does [
	reverse seq
	replace/all/case seq "C" "g"
	replace/all/case seq "G" "c"
	replace/all/case seq "A" "t"
	replace/all/case seq "T" "a"
	replace/all/case seq "M" "k"
	replace/all/case seq "K" "m"
	replace/all/case seq "R" "y"
	replace/all/case seq "Y" "r"
	replace/all/case seq "V" "b"
	replace/all/case seq "B" "v"
	replace/all/case seq "H" "d"
	replace/all/case seq "D" "h"
	uppercase seq
	forskip seq 61 [insert seq "^/"]
	print next seq	; skip first newline character inserted by forskip
]

seq: copy ""
i: input
while [i][
	either (i/1 = #">") [
		if (length? seq) > 0 [rev-compl seq	seq: copy ""]
		print i
	][
		append seq uppercase i
	]
	i: input
]
if (length? seq) > 0 [rev-compl seq]
