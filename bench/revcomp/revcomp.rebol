REBOL [
    Title: "reverse-complement"
    Author: "Robert Brandner"
    Version: "0.3"
]
    
rev-compl3: func [/local res src dst cnt][
    reverse seq
    src: copy "CGATMKRYVBHD"
    dst: copy "GCTAKMYRBVDH"
    res: copy seq
    while [not tail? src][
        run: seq
        while [run: find run first src][
            poke res (index? run) (first dst)
            run: next run
        ]            
        src: next src
        dst: next dst
    ]
    forskip res 60 [print copy/part res 60]
]

seq: copy ""
i: input
while [i] [
    either (i/1 = #">") [
        if (length? seq) > 0 [
            rev-compl3
            seq: copy ""
        ]
        print i
    ][
        append seq i
    ]
    i: input
]
if (length? seq) > 0 [rev-compl3]
