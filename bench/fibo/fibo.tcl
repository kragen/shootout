#!/usr/bin/tclsh
# $Id: fibo.tcl,v 1.6 2005-04-25 19:01:39 igouy-guest Exp $
# http://www.bagley.org/~doug/shootout/

# with help from: Kristoffer Lawson

proc fib {n} {
    if {$n < 2} {
	return 1
    } else {
	return [expr {[fib [incr n -2]] + [fib [incr n]]}]
    }
}

interp recursionlimit {} 10000
puts [fib $argv]
