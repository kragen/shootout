#!/usr/bin/tclsh
# $Id: matrix.tcl,v 1.2 2005-03-31 14:42:10 sgeard-guest Exp $
# http://www.bagley.org/~doug/shootout/

# This program based on the original from:
# "The What, Why, Who, and Where of Python" By Aaron R. Watters
# http://www.networkcomputing.com/unixworld/tutorial/005/005.html

# modified to avoid matrix size checks
# --Doug

# additional speedups by Kristoffer Lawson and Miguel Sofer

set size 30

proc mkmatrix {rows cols} {
    set count 0
    for {set i 0} {$i < $rows} {incr i} {
	set row {}
	for {set j 0} {$j < $cols} {incr j} {lappend row [incr count]}
	lappend mx $row
    }
    return $mx
}

proc mmult {m1 m2} {
    set cols [lindex $m1 0]
    foreach row1 $m1 {
	foreach {row i} {{} 0} break
	foreach - $cols {
	    set elem 0
	    foreach elem1 $row1 row2 $m2 {
		incr elem [expr {$elem1 * [lindex $row2 $i]}]
	    }
	    lappend row $elem
	    incr i
	}
	lappend result $row
    }
    return $result
}

proc main {n} {
    set m1 [mkmatrix $::size $::size]
    set m2 [mkmatrix $::size $::size]
    while {[incr n -1] > -1} {set m [mmult $m1 $m2]}

    puts "[lindex $m 0 0] [lindex $m 2 3] [lindex $m 3 2] [lindex $m 4 4]"
}

set N [lindex $argv 0]
if {$N < 1} {set N 1}
main $N
