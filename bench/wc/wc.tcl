#!/usr/bin/tclsh
# $Id: wc.tcl,v 1.1 2004-05-19 18:13:52 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

# this program is modified from:
#   http://cm.bell-labs.com/cm/cs/who/bwk/interps/pap.html
# Timing Trials, or, the Trials of Timing: Experiments with Scripting
# and User-Interface Languages</a> by Brian W. Kernighan and
# Christopher J. Van Wyk.

# Modified by Miguel Sofer

proc main {} {
    set nl 0
    set nc 0
    set nw 0

    while {1} {
	set data [read stdin 4096]
	if {![string length $data]} {break}
	if {[gets stdin extra] >= 0} {
	    append data $extra
	    incr nc
	}
	incr nc [string length $data]
	incr nw [regexp -all {(?:^|\s)\S} $data]
	incr nl [regexp -all -line {^} $data]
    }
    puts "$nl $nw $nc"
}

main
