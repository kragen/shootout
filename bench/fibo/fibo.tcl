#!/usr/bin/tclsh
# $Id: fibo.tcl,v 1.2 2005-03-19 00:32:56 igouy-guest Exp $
# http://www.bagley.org/~doug/shootout/

# with help from: Kristoffer Lawson

proc fib {n} {
    if {$n < 2} {
	return $n
    } else {
	return [expr {[fib [expr {$n-2}]] + [fib [expr {$n-1}]]}]
    }
}

set N [lindex $argv 0]
if {$N < 1} { set N 1 }
puts [fib $N]
