#!/usr/bin/tclsh
##
## The Computer Lannguage Shootout
## http://shootout.alioth.debian.org/
## Contributed by Heiner Marxen
##
## "spectral-norm"	for Tcl
## Call:	tclsh spectral-norm.tcl N
##
## $Id: spectralnorm.tcl,v 1.1 2005-12-08 03:02:41 igouy-guest Exp $

proc A {i j} {
    return [expr {1.0 / (($i+$j)*($i+$j+1)/2 + $i+1)}]
}

set mulBody {
    set r [list]
    for {set i 0} {$i < $n} {incr i} {
	set sum 0.0
	for {set j 0} {$j < $n} {incr j} {
	    set sum [expr {$sum + [A_i_j] * [lindex $v $j]}]
	}
	lappend r $sum
    }
    return $r
}

proc mulAv  {n v} [string map [list A_i_j {A $i $j}] $mulBody]
proc mulAtv {n v} [string map [list A_i_j {A $j $i}] $mulBody]

proc mulAtAv {n v} {
    return [mulAtv $n [mulAv $n $v]]
}

proc approximate {n} {
    for {set i 0} {$i < $n} {incr i} {
	lappend u 1.0
    }

    for {set i 0} {$i < 10} {incr i} {
	set v [mulAtAv $n $u]
	set u [mulAtAv $n $v]
    }

    set vBv 0.0
    set vv  0.0
    for {set i 0} {$i < $n} {incr i} {
	set vi  [lindex $v $i]
	set vBv [expr {$vBv + $vi * [lindex $u $i]}]
	set vv  [expr {$vv  + $vi * $vi           }]
    }
    return [expr {sqrt( $vBv / $vv )}]
}

proc main {argv} {
    set n 100
    if {[llength $argv]} {set n [lindex $argv 0]}

    puts [format "%.9f" [approximate $n]]

    return 0
}

main $argv
