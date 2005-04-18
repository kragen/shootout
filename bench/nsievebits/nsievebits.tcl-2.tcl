#!/usr/bin/tclsh
# $Id: nsievebits.tcl-2.tcl,v 1.1 2005-04-18 15:43:54 greg-guest Exp $
# http://shootout.alioth.debian.org/
#
# Contributed by Hemang Lavana

proc nsieve {m} {
    set NBITS [set CHAR_BIT 8]

    set init_val [expr {(1 << $CHAR_BIT) - 1}]
    set max [expr {$m / $NBITS}]
    for {set i 0} {$i < $max} {incr i} {lappend data $init_val}

    for {set count 0; set i 2} {$i < $m} {incr i} {
	if {[lindex $data [expr {$i / $NBITS}]] & (1 << $i % $NBITS)} {
            for {set j [expr {$i + $i}]} {$j < $m} {incr j $i} {
                set j_idx [expr {$j / $NBITS}]
	        lset data $j_idx [expr {[lindex $data $j_idx] & ~(1 << $j % $NBITS)}]
            }
	    incr count
        }
    }
    return $count
}

proc main {n} {

    if {[llength $n] > 1 || $n < 2} {
        puts stderr "usage: [file tail $::argv0] N ;#N >= 2, specified value of N = $n"
        exit 2
    }
    foreach value [list $n [incr n -1] [incr n -1]] {
        set m [expr {(1 << $value) * 10000}]
        set count [nsieve $m]
        puts [format "Primes up to %8u%8u" $m $count]
    }
}
main $argv
