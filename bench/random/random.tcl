#!/usr/bin/tclsh
# $Id: random.tcl,v 1.4 2005-09-29 17:36:19 igouy-guest Exp $
# http://www.bagley.org/~doug/shootout/
# from Miguel Sofer 

foreach {IM IA IC last} {139968 3877 29573 42} break

proc make_gen_random {} {
    set params [list IM $::IM IA $::IA IC $::IC]
    set body [string map $params {
	expr {($max * [set ::last [expr {($::last * IA + IC) % IM}]]) / IM}}]
    proc gen_random {max} $body
}

proc main {n} {
    make_gen_random
    while {[incr n -1] > 0} {gen_random 100.0}
    puts [format "%.9f" [gen_random 100.0]]
}

main $argv
