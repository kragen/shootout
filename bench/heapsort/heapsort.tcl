#!/usr/bin/tclsh
# $Id: heapsort.tcl,v 1.1 2004-05-19 18:10:11 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/
# sped up by Miguel Sofer's function generator

set IM 139968
set IA   3877
set IC  29573

set last 42

proc make_gen_random {} {
    global IM IA IC
    set params [list IM $IM IA $IA IC $IC]
    set body [string map $params {
        global last
        expr {($max * [set last [expr {($last * IA + IC) % IM}]]) / IM}
    }]
    proc gen_random {max} $body
}

proc heapsort {n ra_name} {
    upvar $ra_name ra

    set j 0
    set i 0
    set rra 0.0
    set l [expr {($n >> 1) + 1}]
    set ir $n
    while 1 {
        if {$l > 1} {
	    incr l -1
            set rra $ra($l)
        } else {
	    set rra $ra($ir)
	    set ra($ir) $ra(1)
	    incr ir -1
	    if {$ir == 1} {
                set ra(1) $rra
                return
            }
        }
	set i $l
	set j [expr {$l << 1}]
        while {$j <= $ir} {
	    if {($j < $ir) && ($ra($j) < $ra([expr {$j + 1}]))} {
		incr j
	    }
            if {$rra < $ra($j)} {
		set ra($i) $ra($j)
		set i $j
                set j [expr {$j + $i}]
            } else {
		set j [expr {$ir + 1}]
            }
        }
        set ra($i) $rra
    }
}

proc main {} {
    global argv
    set n [lindex $argv 0]
    make_gen_random

    for {set i 1} {$i <= $n} {incr i} {
	set ary($i) [gen_random 1.0]
    }
    heapsort $n ary
    puts [format "%.10f" $ary($n)]
}

main
