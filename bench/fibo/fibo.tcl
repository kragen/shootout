#!/usr/bin/tclsh
# $Id: fibo.tcl,v 1.1 2004-05-19 18:09:49 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

# with help from: Kristoffer Lawson

proc fib {n} {
    if {$n < 2} {
	return 1
    } else {
	return [expr {[fib [expr {$n-2}]] + [fib [expr {$n-1}]]}]
    }
}

set N [lindex $argv 0]
if {$N < 1} { set N 1 }
puts [fib $N]
