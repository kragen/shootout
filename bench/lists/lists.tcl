#!/usr/bin/tclsh
# $Id: lists.tcl,v 1.1 2004-05-19 18:10:25 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/
# from Kristoffer Lawson
# Modified by Tom Wilkason

set SIZE 10000

proc K {a b} {set a}

proc ldelete {listName index} {
    upvar $listName list
    ;# Replace a deletion with null, much faster
    set list [lreplace [K $list [set list {}]] $index $index]
}

proc lreverse {_list} {
    upvar $_list List
    for {set i [expr {[llength $List] - 1}]} {$i >= 0} {incr i -1} {
	lappend Li1r [lindex $List $i]
    }
    set List $Li1r
    unset Li1r
}

proc test_lists {args} {
    # create a list of integers (Li1) from 1 to SIZE
    for {set i 1} {$i <= $::SIZE} {incr i} {lappend Li1 $i}
    # copy the list to Li2 (not by individual items)
    set Li2 $Li1
    # remove each individual item from left side of Li2 and
    # append to right side of Li3 (preserving order)
    lreverse Li2
    foreach {item} $Li2 {
	lappend Li3 [lindex $Li2 end]
	ldelete Li2 end
    }
    # Li2 must now be empty
    # remove each individual item from right side of Li3 and
    # append to right side of Li2 (reversing list)
    foreach {item} $Li3 {
	lappend Li2 [lindex $Li3 end]
	ldelete Li3 end
    }
    # Li3 must now be empty
    # reverse Li1 in place
    lreverse Li1
    # check that first item is now SIZE
    if {[lindex $Li1 0] != $::SIZE} {
	return "fail size [lindex $Li1 0]"
    }
    # compare Li1 and Li2 for equality
    # and return length of the list
    if {$Li1 == $Li2} {
	return [llength $Li1]
    } else {
	return "fail compare"
    }
}

proc main {args} {
    global argv
    set NUM [lindex $argv 0]
    if {$NUM < 1} {
	set NUM 1
    }
    while {$NUM > 0} {
	set result [test_lists]
	incr NUM -1
    }
    puts $result
}

main
