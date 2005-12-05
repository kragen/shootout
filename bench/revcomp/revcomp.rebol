rebol[
	Title:  "reverse-complement"
	Author: "Tom Conlin"
	Date:    2005-12-2
	purpose: {	The Computer Language Shootout
	            http://shootout.alioth.debian.org/gp4/benchmark.php?test=knucleotide&lang=rebol&id=0
	         }
	summary: [rebol reverse-complement tom conlin 2005-12-2]
    version: 0.1
]
flip: does [
    reverse/part :there :here 
    there: skip :there 60 
    word: :there
    forskip word 61[
        there: :word
        insert :there "^/"
        there: next :there
        all[not tail? :here
            here: next :here
            :there <= :here break
        ]
    ]
    either tail? :here
        [insert :here "^/"]
        [   if not find/match back :here "^/"[
               insert back :here "^/" here: next :here
            ]
        ]
]
rule: [
    here:
    ["A" (change :here "T")] | ["C" (change :here "G")]|
    ["G" (change :here "C")] | ["T" (change :here "A")]|
    ["^/"(remove :here) :here]|
    ["U" (change :here "A")] | ["M" (change :here "K")]|
    ["R" (change :here "Y")] | ["Y" (change :here "R")]|
    ["K" (change :here "M")] | ["V" (change :here "B")]|
    ["H" (change :here "D")] | ["D" (change :here "H")]|
    ["B" (change :here "V")] |  "W" | "S" | "N" |
    [">" (all[:here <> :there flip]
          all[not tail? :here here: find/tail next :here "^/"]
         ):here there:
    ]
]
set-modes system/ports/input[lines: false binary: false]
fasta: copy system/ports/input
parse fasta[there: some rule (flip)]
insert system/ports/output fasta
