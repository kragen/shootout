#!/usr/bin/tclsh
# $Id: ackermann.tcl-3.tcl,v 1.2 2005-03-30 22:24:56 sgeard-guest Exp $
# http://shootout.alioth.debian.org/
#
# Updated based on ideas from Stefan Finzel
#
# Further optimized by Mark Butler.
#
# vim: set filetype=tcl:

proc ack {m n} {
    if {$m} {
	if {$n} {
	    #
	    # incr is quicker than an equivalent expr, as long as
	    # you don't mind altering the variable.
	    return [ack [expr {$m - 1}] [ack $m [incr n -1]]]
	} else {
	    return [ack [incr m -1] 1]
	}
    } else {
	return [incr n]
    }
}

interp recursionlimit {} 10000
set N [lindex $argv 0]
if {$N < 1} {set N 1}
puts "Ack(3,$N): [ack 3 $N]"
