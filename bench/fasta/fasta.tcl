#!/usr/bin/tclsh
# $Id: fasta.tcl,v 1.1 2005-03-25 07:59:06 bfulgham Exp $
# http://shootout.alioth.debian.org/

# Fasta benchmark
#
# Contributed by Michael Schlenker (mic42@users.sourceforge.net)

set IM 139968
set IA   3877
set IC  29573
set last 42
set ::tcl_precision 17

set alu GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGGGAGGCCGAGG
append alu CGGGCGGATCACCTGAGGTCAGGAGTTCGAGACCAGCCTGGCCAACATG
append alu GTGAAACCCCGTCTCTACTAAAAATACAAAAATTAGCCGGGCGTGGTGG
append alu CGCGCGCCTGTAATCCCAGCTACTCGGGAGGCTGAGGCAGGAGAATCGC
append alu TTGAACCCGGGAGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCA
append alu CTCCAGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA


set iub {
     a 0.27
     c 0.12
     g 0.12
     t 0.27
     B 0.02
     D 0.02
     H 0.02
     K 0.02
     M 0.02
     N 0.02
     R 0.02
     S 0.02
     V 0.02
     W 0.02
     Y 0.02 }

set homosapiens {
     a 0.3029549426680
     c 0.1979883004921
     g 0.1975473066391
     t 0.3015094502008
}

proc make_gen_random {} {
   global IM IA IC
   set params [list IM $IM IA $IA IC $IC]
   set body [string map $params {
   global last
   expr {($max * [set last [expr {($last * IA + IC) % IM}]]) / IM}
   }]
  proc gen_random {max} $body
}

proc make_cumulative {table} {
     set prob 0.0
     set pl [list]
     foreach {char p} $table {
         lappend pl [set prob [expr {$prob + $p}]] $char
     }
     return $pl
}

 proc make_repeat_fasta {id desc src n} {
    puts ">$id $desc"
    set width 60
    incr n -1
    set l [string length $src]
    set ls [string repeat $src [expr {($n / $l)+1 }]]
    set s 0
    set e [expr {$width-1}]
    while {$e < $n} {
        puts [string range $ls $s $e]
        set s $e
        incr s
        incr e $width
    }
    puts [string range $ls $s $n]
 }

 proc make_random_fasta {id desc src n} {
    puts ">$id $desc"
    set width 60
    set prob [make_cumulative $src]
    set line ""
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
    if {[string length $line]} {
        puts $line
    }
 }

 proc main {} {
   set n [lindex $::argv 0]
   make_gen_random
   make_repeat_fasta ONE "Homo sapiens alu" $::alu [expr {$n*2}]
   make_random_fasta TWO "IUB ambiguity codes" $::iub [expr {$n*3}]
   make_random_fasta THREE "Homo sapiens frequency" $::homosapiens [expr {$n*5}]

 }

 main

