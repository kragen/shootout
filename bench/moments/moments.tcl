#!/usr/bin/tclsh
# $Id: moments.tcl,v 1.2 2005-03-18 06:26:26 bfulgham Exp $
# http://shootout.alioth.debian.org/
#
# Corrected by Randy Melton

proc main {} {
    set sum 0.0
    set nums [read stdin]
    foreach num $nums {
        set sum [expr {$sum + $num}]
    }
    set n [llength $nums]
    set mean [expr {$sum / $n}]
    set average_deviation 0.0
    set standard_deviation 0.0
    set variance 0.0
    set skew 0.0
    set kurtosis 0.0
    
    foreach num $nums {
	set deviation [expr {$num - $mean}]
	set average_deviation [expr {$average_deviation + abs($deviation)}]
	set variance [expr {$variance + pow($deviation, 2)}]
	set skew [expr {$skew + pow($deviation, 3)}]
	set kurtosis [expr {$kurtosis + pow($deviation, 4)}]
    }

    set average_deviation [expr {$average_deviation / $n}]
    set variance [expr {$variance / ($n - 1)}]
    set standard_deviation [expr {sqrt($variance)}]

    if {$variance} {
	set skew [expr {$skew / ($n * $variance * $standard_deviation)}]
	set kurtosis [expr {$kurtosis / ($n * $variance * $variance) - 3.0}]
    }

    set nums [lsort -integer $nums]
    set mid [expr {int($n / 2)}]
    if [expr {$n % 2}] {
	set median [lindex $nums $mid]
    } else {
	set a [lindex $nums $mid]
	set b [lindex $nums [expr {$mid - 1}]]
	set median [expr {($a + $b) / 2.0}]
    }
	
    puts [format "n:                  %d" $n]
    puts [format "median:             %f" $median]
    puts [format "mean:               %f" $mean]
    puts [format "average_deviation:  %f" $average_deviation]
    puts [format "standard_deviation: %f" $standard_deviation]
    puts [format "variance:           %f" $variance]
    puts [format "skew:               %f" $skew]
    puts [format "kurtosis:           %f" $kurtosis]
}

main
