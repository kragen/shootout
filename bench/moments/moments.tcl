#!/usr/bin/tclsh
# $Id: moments.tcl,v 1.4 2005-03-31 14:51:07 sgeard-guest Exp $
# http://www.bagley.org/~doug/shootout/

proc main {} {
    foreach {sum average_deviation variance skew kurtosis} {0 0 0 0 0} break

    set nums [read stdin]
    foreach num $nums { incr sum $num }
    set n [llength $nums]
    set mean [expr {double($sum) / $n}]

    foreach num $nums {
	set deviation [expr {$num - $mean}]
	set dev2 [expr {$deviation * $deviation}]
	set dev3 [expr {$dev2 * $deviation}]
	set dev4 [expr {$dev3 * $deviation}]
	set average_deviation [expr {$average_deviation + abs($deviation)}]
	set variance [expr {$variance + $dev2}]
	set skew [expr {$skew + $dev3}]
	set kurtosis [expr {$kurtosis + $dev4}]
    }

    set average_deviation [expr {$average_deviation / $n}]
    set variance [expr {$variance / ($n - 1)}]
    set standard_deviation [expr {sqrt($variance)}]

    if {$variance} {
	set skew [expr {$skew / ($n * $variance * $standard_deviation)}]
	set kurtosis [expr {$kurtosis / ($n * $variance * $variance) - 3}]
    }

    set nums [lsort -integer $nums]
    set mid [expr {int($n / 2)}]
    if [expr {$n % 2}] {
	set median [lindex $nums $mid]
    } else {
	set a [lindex $nums $mid]
	set b [lindex $nums [incr mid -1]]
	set median [expr {double($a + $b) / 2}]
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
