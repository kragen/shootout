rebol[
	Title:  "k-nucleotide"
	Author: "Tom Conlin"
	Date:    2005-11-14
	purpose: {	The Great Computer Language Shootout
	            http://shootout.alioth.debian.org/
	         }
	summary: [rebol k-nucleotide tom conlin 2005-11-27]
    version: 1.17
]
;;; format utility 
decimal-pad: func[d[number!] p[integer!] /local r s t][
	d: to string! d
	either s: find/tail d "."
		[   either p >= length? s
			[insert/dup tail s "0" p - length? s]
			[	t: skip s p
				r: either #"5" > first t[0][10]
				while[not zero? r: to integer! r / 10][
					t: back t if #"." == first t[t: back t]
					r: -47 + first t
					change t r // 10
					if all[9 < r any[head? t #"-" == first t]][
						insert d "0" s: next s
					]
				]
				clear skip s p
			]
		]
		[insert tail d "." insert/dup tail d "0" p]
	d
]

;;; read line-by-line a redirected FASTA format file from stdin
set-modes system/ports/input [lines: false binary: false]

;;; extract DNA sequence THREE
here: find/tail find/tail copy system/ports/input "^/>THREE " "^/"
fasta: replace/all  here "^/" ""
len: 1 + length? fasta

k-nucl: func ["function to update a hash of k-nucleotide keys and count values"
    k [integer!] n[series!] hash [block!] /local l m ][
        m: copy/part n k
        either k = length? m
        [either l: find hash/:k m
                [l: next l change l 1 + first l]
                [insert tail hash/:k m insert tail hash/:k 1]
        ][return]
]

;;; count all the 3- 4- 6- 12- and 18-nucleotide sequences,
kay: [1 2 3 4 6 12 18]
mers: make block! last kay ;;; could sort if not ordered
loop last kay [insert/only tail mers make hash![]]

forall fasta[ kay: head kay
        forall kay[k-nucl first kay fasta mers]
]

;;; for all the 1-nucleotide and 2-nucleotide sequences,
;;; sorted by descending frequency and then ascending k-nucleotide key
repeat i 2 [sort/skip mers/:i 2 sort/skip head reverse mers/:i 2
        foreach [n c] head reverse mers/:i[
            print[uppercase n decimal-pad 100 * c / (len - i) 3]
        ]print ""
]

;;; write the count and code for specific sequences
foreach seq ["GGT" "GGTA" "GGTATT" "GGTATTTTAATT" "GGTATTTTAATTTATAGT"][
        l: length? seq ;;; newer REBOL versions would not need this line
        print rejoin[either c: select mers/:l seq [c]["0"] tab seq]
]
