rebol[ 
    summary: [rebol sum-file tom conlin 2005-11-26]
    version: 0.2
]
set-modes system/ports/input[lines: false binary: false]
b: load copy system/ports/input s: 0
foreach i b[s: s + i]
print s
