#!/usr/bin/tclsh
# $Id: nsievebits.tcl,v 1.2 2005-04-19 16:42:48 igouy-guest Exp $
# http://shootout.alioth.debian.org/
#
# Contributed by Hemang Lavana

proc nsieve {m} {
    set NBITS 8
    set CHAR_BIT 8

    set init_val [expr {(1 << $CHAR_BIT) - 1}]
    set max [expr {$m / $NBITS}]
    set data {}
    for {set i 0} {$i < $max} {incr i} {
        lappend data $init_val
    }

    set count 0
    for {set i 2} {$i < $m} {incr i} {
        set i_idx [expr {$i / $NBITS}]
	if {[lindex $data $i_idx] & (1 << $i % $NBITS)} {
            for {set j [expr {$i + $i}]} {$j < $m} {incr j $i} {
                set j_idx [expr {$j / $NBITS}]
	        lset data $j_idx \
                    [expr {[lindex $data $j_idx] & ~(1 << $j % $NBITS)}]
            }
	    incr count
        }
    }
    return $count
}

proc test {n} {
    set m [expr {(1 << $n) * 10000}]
    set count [nsieve $m]
    puts [format "Primes up to %8u %8u" $m $count]
}

proc usage {} {
    set script [file tail $::argv0]
    puts stderr "usage: $script N ;#where N >= 2"
    exit 2
}

proc main {argv} {

    set len [llength $argv]
    set n [lindex $argv 0]
    if {$len < 1} {
        usage
    }
    if {$n < 2} {
        exit 2
    }
    foreach value [list $n [incr n -1] [incr n -1]] {
        test $value
    }
}
main $argv
