rebol[
	Title:  "fasta"
	Author: "Tom Conlin"
	Date:    2005-11-29
	purpose: {	The Great Computer Language Shootout
	            http://shootout.alioth.debian.org/gp4/benchmark.php?test=fasta
	         }
	summary: [rebol fasta tom conlin 2005-11-29]
    version: 0.1
]

ALU: {GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG
GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA
CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT
ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA
GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG
AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC
AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA}

IUB: [0.27 0.12 0.12 0.27] loop 11[insert tail IUB 0.02]
HomoSap: [0.3029549426680 0.1979883004921 0.1975473066391 0.3015094502008]

repeat-fasta: func [n [integer!] seq[series!] /local rest][
	seq: replace/all seq "^/" ""
	loop to integer!(n / 60)[
		either 60 < length? seq
			[print copy/part seq 60
			 seq: skip seq 60
			][rest: 60 - length? seq
			 print head insert tail copy seq copy/part head seq rest
			 seq: skip head seq rest
			]
	]
	if not zero? rest: n // 60 [
		either rest <= length? seq
			[print copy/part seq rest]
			[print head insert tail copy seq copy/part head seq rest - length? seq]
	]
]

rand-fasta: func [n[integer!] probs[block!] /local prev line][
	symbol: ["a" "c" "g" "t" "B" "D" "H" "K" "M" "N" "R" "S" "V" "W" "Y"]
	line: make string! 60
	probs: next probs
	forall probs[change probs add first back probs first probs]
	probs: head probs
	loop to integer! (n / 60)[
		loop 60 [insert tail line pick symbol bin-srch probs gen-rand]
		print line clear line
	]
	loop n // 60[insert tail line pick symbol bin-srch probs gen-rand]
	if not empty? line [print line]
]

gen-rand: does[
	prev: prev * 3877 + 29573 // 139968
	.00000714449016918152720622 * prev
]
bin-srch: func[b k /local l m h][
	l: 1 h: length? b m: to integer!(h - l / 2)+ l
	while[l <= h][either k = b/:m [return m]
		[either k > b/:m[l: m + 1][h: m - 1]]
		m: to integer!(h - l / 2)+ l
	] 1 + m
]

n: either n: system/script/args[to integer! n][1000]
print ">ONE Homo sapiens alu"
repeat-fasta 2 * n ALU
prev: 42
print ">TWO IUB ambiguity codes"
rand-fasta  3 * n IUB
print ">THREE Homo sapiens frequency"
rand-fasta  5 * n HomoSap
