#!/usr/bin/tclsh
# $Id: hash.tcl,v 1.1 2004-05-19 18:09:55 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

# this program is modified from:
#   http://cm.bell-labs.com/cm/cs/who/bwk/interps/pap.html
# Timing Trials, or, the Trials of Timing: Experiments with Scripting
# and User-Interface Languages</a> by Brian W. Kernighan and
# Christopher J. Van Wyk.

proc main {} {
    global argv
    set n [lindex $argv 0]
    for {set i 1} {$i <= $n} {incr i} {
        set x([format {%x} $i]) $i
    }
    set c 0
    for {set i $n} {$i > 0} {incr i -1} {
	if {[info exists x($i)]} {
	    incr c
	}
    }
    puts $c
}

main
