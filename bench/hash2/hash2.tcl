#!/usr/bin/tclsh
# $Id: hash2.tcl,v 1.2 2004-11-30 07:10:03 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/
# with help from Branko Vesligaj and Hemang Lavana

proc main {} {
    global argv
    set n [lindex $argv 0]
    for {set i 0} {$i < 10000} {incr i} {
	set hash1(foo_$i) $i
    }
    for {set i $n} {$i > 0} {incr i -1} {
	foreach k [array names hash1] {
            if {[info exists hash2($k)]} {
                set hash2($k) [expr {$hash1($k) + $hash2($k)}]
            } else {
		set hash2($k) $hash1($k)
	    }
	}
    }
    puts [join [list $hash1(foo_1) $hash1(foo_9999) $hash2(foo_1) $hash2(foo_9999) ] " "]
}

main
