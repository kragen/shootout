#!/usr/bin/tclsh
# $Id: fibo.tcl,v 1.5 2005-04-04 14:56:35 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

# with help from: Kristoffer Lawson

proc fib {n} {
    if {$n < 2} {
	return $n
    } else {
	return [expr {[fib [incr n -2]] + [fib [incr n]]}]
    }
}

interp recursionlimit {} 10000
puts [fib $argv]
