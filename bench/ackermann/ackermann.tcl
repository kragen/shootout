#!/usr/bin/tclsh
# $Id: ackermann.tcl,v 1.3 2005-03-15 06:17:49 bfulgham Exp $
# http://shootout.alioth.debian.org/
#
# Updated based on ideas from Stefan Finzel
#
# Further optimized by Mark Butler.
#
# vim: set filetype=tcl:

set NUM [lindex $argv 0]
if {$NUM < 1} {
    set NUM 1
}

proc ack {m n} {
    if {$m} {
	if {$n} {
            #
            # incr is quicker than an equivalent expr, as long as
            # you don't mind altering the variable.
            incr n -1
	    return [ack [expr {$m - 1}] [ack $m $n]]
	} else {
	    return [ack [expr {$m - 1}] 1]
	}
    } else {
	return [incr n]
    }
}

interp recursionlimit {} 10000
puts "Ack(3,$NUM): [ack 3 $NUM]"
