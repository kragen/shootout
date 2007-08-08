# The Computer Language Benchmarks Game
# http://shootout.alioth.debian.org
# contributed by Michael Schlenker
# small modification by Andrew McParland

foreach {IM IA IC last} {139968 3877 29573 42} break

set alu GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGGGAGGCCGAGGCGGGCGGATCACCTGAGGT
append alu CAGGAGTTCGAGACCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAATACAAAAATTAGCC
append alu GGGCGTGGTGGCGCGCGCCTGTAATCCCAGCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCC
append alu GGGAGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCCAGCCTGGGCGACAGAGCGAGACT
append alu CCGTCTCAAAAA

set iub {a 0.27 c 0.12 g 0.12 t 0.27 B 0.02 D 0.02 H 0.02 K 0.02 M 0.02 N 0.02
	 R 0.02 S 0.02 V 0.02 W 0.02 Y 0.02}

set hsapiens {a 0.3029549426680 c 0.1979883004921 g 0.1975473066391
		 t 0.3015094502008}

proc make_gen_random {} {
    set params [list IM $::IM IA $::IA IC $::IC]
    set body [string map $params {
	expr {($max * [set ::last [expr {($::last * IA + IC) % IM}]]) / IM}}]
    proc gen_random {max} $body
}

proc make_cumulative {table} {
    set prob 0.0
    set pl [list]

    foreach {char p} $table {lappend pl [set prob [expr {$prob + $p}]] $char}
    return $pl
}

proc make_repeat_fasta {id desc src n} {
    foreach {width s e s2 e2} {59 0 59 0 59} break

    puts ">$id $desc"
    set src2 "$src$src"
    set l [string length $src]
    while {$e < $n} {
        puts [string range $src2 $s2 $e2]
	set s [incr e]
	incr e $width
	set s2 [expr {$s % $l}]
	set e2 [expr {$s2 + $width}]
    }
    set rem [expr {$n % ($width + 1)}]
    if {$rem} {puts [string range $src2 $s2 [expr {$s2 + $rem - 1}]]}
}

proc make_random_fasta {id desc src n} {
    foreach {width line} {60 ""} break

    puts ">$id $desc"
    set prob [make_cumulative $src]
    for {set i 0} {$i < $n} {incr i} {
	set rand [gen_random 1.0]
	foreach {p c} $prob {
	    if {$p > $rand} {
		append line $c
		break
	    }
	}
	if {[string length $line] == $width} {
	    puts $line
	    set line ""
	}
    }
    if {[string length $line]} {puts $line}
}

proc main {n} {
    make_gen_random
    make_repeat_fasta ONE "Homo sapiens alu" $::alu [expr {$n*2}]
    make_random_fasta TWO "IUB ambiguity codes" $::iub [expr {$n*3}]
    make_random_fasta THREE "Homo sapiens frequency" $::hsapiens [expr {$n*5}]
}

set N [lindex $argv 0]
if {$N < 1} {set N 1}
main $N
