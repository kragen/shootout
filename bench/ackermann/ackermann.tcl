#!/usr/bin/tclsh
# $Id: ackermann.tcl,v 1.2 2005-02-19 17:05:38 bfulgham Exp $
# http://shootout.alioth.debian.org/
#
# Updated based on ideas from Stefan Finzel

set NUM [lindex $argv 0]
if {$NUM < 1} {
    set NUM 1
}

proc ack {m n} {
    if {$m} {
	if {$n} {
	    return [ack [expr {$m - 1}] [ack $m [expr {$n - 1}]]]
	} else {
	    return [ack [expr {$m - 1}] 1]
	}
    } else {
	return [incr n]
    }
}

set ack [ack 3 $NUM]
puts "Ack(3,$NUM): $ack"
