#!/usr/bin/tclsh
# $Id: fannkuch.tcl,v 1.1 2005-03-18 07:32:18 bfulgham Exp $
# http://shootout.alioth.debian.org/

# Contributed by Robert Seeger

proc getCount {length data} {
    set slot1 [lindex $data 0]
    for {set i 0} {$slot1 != 1} {incr i ; set slot1 [lindex $data 0]} {
        incr slot1 -1
        for {set j [expr {($slot1 - 1) / 2}] } {$j >= 0} {incr j -1} {
            set index [expr {$slot1 - $j}]
            set tmp [lindex $data $j]
            lset data $j [lindex $data $index]
            lset data $index $tmp
        }
    }

    return $i
}

proc nextperm { perm } {
    set length [llength $perm]

    set j [expr { $length - 1 }]
    set ajp1 [lindex $perm $j]
    while { $j > 0 } {
        incr j -1
        set aj [lindex $perm $j]
        if { [string compare $ajp1 $aj] > 0 } {
            set foundj {}
            break
        }
        set ajp1 $aj
    }
    if { ![info exists foundj] } return

    # Find the smallest element greater than the j'th among the elements
    # following aj. Let its index be l, and interchange aj and al.

    set l [expr { $length - 1 }]
    while { $aj >= [set al [lindex $perm $l]] } {
        incr l -1
    }
    lset perm $j $al
    lset perm $l $aj

    # Reverse a_j+1 ... an

    set k [expr {$j + 1}]
    set l [expr { $length - 1 }]
    while { $k < $l } {
        set al [lindex $perm $l]
        lset perm $l [lindex $perm $k]
        lset perm $k $al
        incr k
        incr l -1
    }

    return $perm

}

proc main {inputs} {
    set n [lindex $inputs 0]

    set base {}
    for {set i 1} {$i <= $n} {incr i} {
        lappend base $i
    }

    set maxCount 0
    set currCount 0

    set perm $base
    while {[llength $perm]} {
        if { [set currCount [getCount $n $perm]] > $maxCount } {
            set maxCount $currCount
        }
        set perm [nextperm $perm]
    }

    puts "Pfannkuchen($n) = $maxCount"
}

main $argv
