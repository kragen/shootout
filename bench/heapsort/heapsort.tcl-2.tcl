#!/usr/bin/tclsh
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# sped up by Miguel Sofer's function generator
# modified by Daniel South

foreach {IM IA IC last} {139968 3877 29573 42} break

proc make_gen_random {} {
    set params [list IM $::IM IA $::IA IC $::IC]
    set body [string map $params {
	expr {($max * [set ::last [expr {($::last * IA + IC) % IM}]]) / IM}}]
    proc gen_random {max} $body
}

proc heapsort {n ra_name} {
    upvar 1 $ra_name ra

    set l [expr {($n >> 1) + 1}]
    while 1 {
        if {$l > 1} {
            set rra [lindex $ra [incr l -1]]
        } else {
	    set rra [lindex $ra $n]
	    lset ra $n [lindex $ra 1]
	    if {[incr n -1] == 1} {return [lset ra 1 $rra]}
        }
	set i $l
	set j [expr {$l << 1}]
        while {$j <= $n} {
	    if {$j < $n && [lindex $ra $j] < [lindex $ra [expr {$j + 1}]]} {
		incr j
	    }
            if {$rra < [lindex $ra $j]} {
		lset ra $i [lindex $ra $j]
		set i $j
                incr j $j
            } else {
		set j $n
		incr j
            }
        }
        lset ra $i $rra
    }
}

proc main {n} {
    make_gen_random
    for {set i 1} {$i <= $n} {incr i} {lappend data [gen_random 1.0]}
    incr n -1
    heapsort $n data
    puts [format "%.10f" [lindex $data $n]]
}

set N [lindex $argv 0]
if {$N < 1} {set N 1}
main $N
