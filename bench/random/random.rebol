rebol[
	summary: [rebol random tom conlin 2005-11-26]
	version 0.1
]
;do %decimal-pad.r
decimal-pad: func [d[number!] p[integer!] /local r s t][
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

prandom: context[
	IM: 139968
	IA: 3877
	IC: 29573
	last: 42.0
	gen-prandom: func [max[decimal!]][
		last:  last * IA + IC // IM
		max * last / IM
	]
	set 'advance-prandom func[N [integer!]][loop N[gen-prandom 100.0]]
	set 'reset-prandom does[last: 42.0]
]
N: either N: system/script/args[N][1]
print decimal-pad advance-prandom to integer! N 9
