#!/usr/bin/tclsh
# $Id: wc.tcl,v 1.2 2005-03-30 22:22:23 sgeard-guest Exp $
# http://www.bagley.org/~doug/shootout/

# this program is modified from:
#   http://cm.bell-labs.com/cm/cs/who/bwk/interps/pap.html
# Timing Trials, or, the Trials of Timing: Experiments with Scripting
# and User-Interface Languages</a> by Brian W. Kernighan and
# Christopher J. Van Wyk.

# Modified by Miguel Sofer

proc main {} {
    foreach {nl nc nw inword} {0 0 0 0} break

    while {[set data [read stdin 4096]] != {}} {
	incr nc [string length $data]
	set T1 [split $data "\n\r\t "]
	set T2 [lsearch -all -inline -exact -not $T1 {}]
	if {$inword && ([lindex $T1 0] == {})} {incr nw}
	set inword 0
	if {[llength $T2]} {
	    incr nw [llength $T2]
	    if {[lindex $T1 end] != {}} {
		incr nw -1
		set inword 1
	    }
	}
	incr nl [llength [split $data "\n\r"]]
	incr nl -1
    }
    puts "$nl $nw $nc"
}

main
