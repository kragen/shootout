#!/usr/bin/tclsh
# $Id: matrix.tcl,v 1.1 2004-05-19 18:10:35 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

# This program based on the original from:
# "The What, Why, Who, and Where of Python" By Aaron R. Watters
# http://www.networkcomputing.com/unixworld/tutorial/005/005.html

# modified to avoid matrix size checks
# --Doug

# additional speedups by Kristoffer Lawson and Miguel Sofer

set size 30;

proc mkmatrix {rows cols} {
    set count 1;
    set mx [list]
    for { set i 0 } { $i < $rows } { incr i } {
	set row [list]
	for { set j 0 } { $j < $cols } { incr j } {
	    lappend row $count;
	    incr count;
	}
	lappend mx $row;
    }
    return $mx;
}

proc mmult {m1 m2} {
    set cols [lindex $m2 0]
    foreach row1 $m1 {
        set row [list]
        set i 0
        foreach - $cols {
            set elem 0
            foreach elem1 $row1 row2 $m2 {
                set elem [expr {$elem + $elem1 * [lindex $row2 $i]}]
            }
            lappend row $elem
            incr i
        }
        lappend result $row
    }
    return $result
}

proc main {} {
    global argv size
    set num [lindex $argv 0]
    if {$num < 1} {
	set num 1
    }

    set m1 [mkmatrix $size $size]
    set m2 [mkmatrix $size $size]
    while {$num > 0} {
        incr num -1
        set m [mmult $m1 $m2]
    }

    puts "[lindex [lindex $m 0] 0] [lindex [lindex $m 2] 3] [lindex [lindex $m 3] 2] [lindex [lindex $m 4] 4]"
}

main
