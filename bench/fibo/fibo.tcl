#!/usr/bin/tclsh
# $Id: fibo.tcl,v 1.4 2005-04-02 07:16:04 igouy-guest Exp $
# http://www.bagley.org/~doug/shootout/

# with help from: Kristoffer Lawson

proc fib {n} {
    if {$n < 2} {
	return $n
    } else {
	return [expr {[fib [incr n -2]] + [fib [incr n]]}]
    }
}

puts [fib $argv]
