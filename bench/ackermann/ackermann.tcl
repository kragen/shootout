#!/usr/bin/tclsh
# $Id: ackermann.tcl,v 1.1 2004-05-19 18:09:09 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

set NUM [lindex $argv 0]
if {$NUM < 1} {
    set NUM 1
}

proc ack {m n} {
    if {$m == 0} {
	return [expr {$n + 1}]
    } elseif {$n == 0} {
	return [ack [expr {$m - 1}] 1]
    } else {
	return [ack [expr {$m - 1}] [ack $m [expr {$n - 1}]]]
    }
}

set ack [ack 3 $NUM]
puts "Ack(3,$NUM): $ack"
