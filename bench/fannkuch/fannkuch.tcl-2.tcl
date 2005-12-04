#!/usr/bin/tclsh
##
## The Computer Lannguage Shootout
## http://shootout.alioth.debian.org/
## Contributed by Heiner Marxen
##
## "fannkuch"	for Tcl
## Call:	tclsh fannkuch.tcl 9
##
## $Id: fannkuch.tcl-2.tcl,v 1.1 2005-12-04 23:58:38 igouy-guest Exp $

proc fannkuch {n} {
    if {$n < 1} {
	return 0
    }
    set n1 [expr {$n - 1}]		;# just caches n-1

    set nL [list]			;# caches list < $n
    for {set i 0} {$i < $n} {incr i} {
	lappend nL $i
    }
    foreach j $nL {
	set L [list]
	set k $j
	for {set i 0} {$i < $k} {incr i; incr k -1} {
	    lappend L $i $k
	}
	set IK($j) $L		;# caches inner loop as above
	;# quadratic overhead is ok for factorial usage
    }

    foreach i $nL {
	set perm1($i) $i		;# initial (trivial) permu
    }

    set r        $n
    set didpr    0
    set flipsMax 0
    while 1 {
	if {$didpr < 30} {
	    foreach i $nL {
		puts -nonewline "[expr {1 + $perm1($i)}]"
	    }
	    puts ""
	    incr didpr
	}
	for {} {$r != 1} {incr r -1} {
	    set count([expr {$r-1}]) $r
	}

	if {! ($perm1(0) == 0  ||  $perm1($n1) == $n1)} {
	    set flips 0

	    ;#array set perm [array get perm1]	;# is slower
	    foreach i $nL {
		set perm($i) $perm1($i)		;# perm = perm1
	    }
	    for {set k $perm(0)} {$k} {set k $perm(0)} {
		;#for {set i 0} {$i < $k} {incr i; incr k -1}
		foreach {i k} $IK($k) {
		    set t $perm($i)
		    set    perm($i) $perm($k)
		    set              perm($k) $t
		    ;# the foreach exchange approach is much slower, here
		}
		incr flips
	    }

	    if {$flipsMax < $flips} {
		set flipsMax $flips
	    }
	}

	while 1 {
	    if {$r == $n} {
		return $flipsMax
	    }
	    ;# rotate down perm[0..r] by one
	    set perm0 $perm1(0)
	    for {set i 0} {$i < $r} {} {
		set perm1($i) $perm1([incr i])	;# tricky: increment embedded
	    }
	    set perm1($r) $perm0
	    if {[incr count($r) -1] > 0} {
		break
	    }
	    incr r
	}
    }
}

proc main {argv} {
    set n 0
    if {[llength $argv]} {
	set n [lindex $argv 0]
    }
    puts "Pfannkuchen($n) = [fannkuch $n]"
    return 0
}

main $argv
