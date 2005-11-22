#!/usr/bin/tclsh
# $Id: fannkuch.tcl,v 1.6 2005-11-22 19:35:09 igouy-guest Exp $
# http://shootout.alioth.debian.org/ 

# Contributed by Robert Seeger

proc getCount {length data} {
    set slot1 [lindex $data 0]
    for {set i 0} {$slot1 != 1} {incr i} {
	for {set j [expr {([incr slot1 -1] - 1) / 2}] } {$j >= 0} {incr j -1} {
	    set index [expr {$slot1 - $j}]
	    set tmp [lindex $data $j]
	    lset data $j [lindex $data $index]
	    lset data $index $tmp
	}
	set slot1 [lindex $data 0]
    }
    return $i
}

proc nextperm {perm} {
    set length [llength $perm]

    set foundj 1
    set j [incr length -1]
    set ajp1 [lindex $perm end]
    while {[incr j -1] > -1} {
	set aj [lindex $perm $j]
	if {[string compare $ajp1 $aj] > 0} {
	    set foundj 0
	    break
	}
	set ajp1 $aj
    }
    if {$foundj} return

    # Find the smallest element greater than the j'th among the elements
    # following aj. Let its index be l, and interchange aj and al.

    set l [incr length]
    while {$aj >= [set al [lindex $perm [incr l -1]]]} {}
    lset perm $j $al
    lset perm $l $aj

    # Reverse a_j+1 ... an

    set l $length
    while {[incr j] < [incr l -1]} {
	set al [lindex $perm $l]
	lset perm $l [lindex $perm $j]
	lset perm $j $al
    }
    return $perm
}

proc main {n} {
    foreach {maxCount currCount} {0 0} break

    for {set i 1} {$i <= $n} {incr i} {
	lappend perm $i
    }
    while {[llength $perm]} {
	if {[set currCount [getCount $n $perm]] > $maxCount} {
	    set maxCount $currCount
	}
	set perm [nextperm $perm]
    }
    puts "Pfannkuchen($n) = $maxCount"
}

main $argv
