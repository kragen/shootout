#!/usr/bin/tclsh
# $Id: fibo.tcl,v 1.3 2005-03-30 22:37:02 sgeard-guest Exp $
# http://www.bagley.org/~doug/shootout/

# with help from: Kristoffer Lawson

proc fib {n} {
    if {$n < 2} {
	return 1
    } else {
	return [expr {[fib [incr n -2]] + [fib [incr n]]}]
    }
}

puts [fib $argv]
