#!/usr/bin/tclsh
#
#  The Great Computer Language Shootout
#  http://shootout.alioth.debian.org/
#
#  Contributed by David Jones

set NUM [lindex $argv 0]
if {$NUM < 1} {
    set NUM 1
}

proc tak {x y z} {
    if {$y >= $x} {
	return $z
    }
    return [tak [tak [expr {$x - 1.0}] $y $z] [tak [expr {$y - 1.0}] $z $x] [tak [expr {$z - 1.0}] $x $y]]
}

set tak [tak [expr {3.0 * $NUM}] [expr {2.0 * $NUM}] [expr {1.0 * $NUM}]]
puts "$tak"
	      
