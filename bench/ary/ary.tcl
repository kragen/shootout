#!/usr/bin/tclsh
# $Id: ary.tcl,v 1.1 2004-05-19 18:09:16 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

# this program is modified from:
#   http://cm.bell-labs.com/cm/cs/who/bwk/interps/pap.html
# Timing Trials, or, the Trials of Timing: Experiments with Scripting
# and User-Interface Languages</a> by Brian W. Kernighan and
# Christopher J. Van Wyk.

proc main {} {
    global argv
    set n [lindex $argv 0]

    for {set i 0} {$i < $n} {incr i} {
	set x($i) $i
    }
    set last [expr {$n - 1}]
    for {set j $last} {$j >= 0} {incr j -1} {
	set y($j) $x($j)
    }
    puts $y($last)
}

main
