#!/usr/bin/tclsh
# $Id: ackermann.tcl,v 1.5 2005-03-30 22:24:54 sgeard-guest Exp $
# http://shootout.alioth.debian.org/
#
# Updated based on ideas from Stefan Finzel
#
# Further optimized by Mark Butler.
#
# vim: set filetype=tcl:

proc ack {n m} {
    if {$m} {
	if {$n} {
	    #
	    # incr is quicker than an equivalent expr, as long as
	    # you don't mind altering the variable.
	    return [ack [ack [incr n -1] $m] [incr m -1]]
	} else {
	    return [ack 1 [incr m -1]]
	}
    } else {
	return [incr n]
    }
}

interp recursionlimit {} 10000
set N [lindex $argv 0]
if {$N < 1} {set N 1}
puts "Ack(3,$N): [ack $N 3]"
