# The Computer Language Shootout
# http://shootout.alioth.debian.org/
# contributed by Heiner Marxen, modified for regexp by Andrew McParland

proc regex-dna {} {
    set seq [read stdin]
    set ilen    [string length $seq]

    regsub -all -line {^>.*\n|\n} $seq {} seq
    set clen    [string length $seq]

    foreach pat [list   {agggtaaa|tttaccct}     \
            {[cgt]gggtaaa|tttaccc[acg]} \
            {a[act]ggtaaa|tttacc[agt]t} \
            {ag[act]gtaaa|tttac[agt]ct} \
            {agg[act]taaa|ttta[agt]cct} \
            {aggg[acg]aaa|ttt[cgt]ccct} \
            {agggt[cgt]aa|tt[acg]accct} \
            {agggta[cgt]a|t[acg]taccct} \
            {agggtaa[cgt]|[acg]ttaccct} \
        ] {
    set cnt [regexp -all -nocase -- $pat $seq]
    puts "$pat $cnt"
    }

    lappend map B {(c|g|t)} D {(a|g|t)} H {(a|c|t)} K {(g|t)}
    lappend map M {(a|c)}   N {(a|c|g|t)}   R {(a|g)}   S {(c|g)}
    lappend map V {(a|c|g)} W {(a|t)}   Y {(c|t)}

    foreach {in out} $map {
        regsub -all $in $seq $out seq
    }

    puts {}
    puts $ilen
    puts $clen
    puts [string length $seq]

    return 0
}

regex-dna
