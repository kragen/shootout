#!/usr/bin/tclsh
# $Id: ary.tcl,v 1.3 2004-06-30 07:28:57 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

# this program is modified from:
#   http://cm.bell-labs.com/cm/cs/who/bwk/interps/pap.html
# Timing Trials, or, the Trials of Timing: Experiments with Scripting
# and User-Interface Languages</a> by Brian W. Kernighan and
# Christopher J. Van Wyk.
# With suggestions by Juan Carlos Gil Montoro

proc main {} {
    global argv
    set n [lindex $argv 0]
    set last [expr {$n - 1}]
    for {set i 0} {$i < $n} {incr i} {
	set x($i) [expr {$i + 1}]
	set y($i) 0
    }
    for {set k 0} {$k < 1000} {incr k} {
	for {set j $last} {$j >= 0} {incr j -1} {
	    incr y($j) $x($j)
	}
    }
    puts "$y(0) $y($last)"
}

main
