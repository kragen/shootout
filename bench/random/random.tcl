#!/usr/bin/tclsh
# $Id: random.tcl,v 1.1 2004-05-19 18:11:17 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/
# from Miguel Sofer

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

proc main {} {
    global argv

    set N [expr {[lindex $argv 0] - 1}]
    make_gen_random

    while {$N} {
        gen_random 100.0
        incr N -1
    }

    puts [format "%.9f" [gen_random 100.0]]
}

main
