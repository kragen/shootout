#!/usr/bin/tclsh
# $Id: sieve.tcl,v 1.1 2004-05-19 18:12:28 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/
# with help from: Kristoffer Lawson

proc sieve {num} {
    while {$num > 0} {
	incr num -1
	set count 0
	for {set i 2} {$i <= 8192} {incr i 1} {
	    set flags($i) 1
	}
	for {set i 2} {$i <= 8192} {incr i 1} {
	    if {$flags($i) == 1} {
		# remove all multiples of prime: i
		for {set k [expr {$i+$i}]} {$k <= 8192} {incr k $i} {
		    set flags($k) 0
		}
		incr count 1
	    }
	}
    }
    return $count
}

set NUM [lindex $argv 0]
if {$NUM < 1} {
    set NUM 1
}

set count [sieve $NUM]
puts "Count: $count"
