#!/usr/bin/tclsh
#
#  The Great Computer Language Shootout
#  http://shootout.alioth.debian.org/
#
#  Contributed by David Jones

proc tak {x y z} {
    if {$y >= $x} {return $z}
    return [tak [tak [expr {$x - 1.0}] $y $z] [tak [expr {$y - 1.0}] $z $x] [tak [expr {$z - 1.0}] $x $y]]
}

set N [lindex $argv 0]
if {$N < 1} {set N 1}
puts [tak [expr {3.0 * $N}] [expr {2.0 * $N}] [expr {1.0 * $N}]]
