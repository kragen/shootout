#!/usr/bin/tclsh
# $Id: regexmatch.tcl,v 1.2 2005-03-31 15:25:14 sgeard-guest Exp $
# http://www.bagley.org/~doug/shootout/
# from: Miguel Sofer, with modifications by Kristoffer Lawson

proc main {n} {
    set data [read stdin]
    set count 0
    set rExp {(?:^|[^\d(])(\(\d{3}\)|\d{3}) (\d{3}[ -]\d{4})(?:$|[^\d])}

    while {[incr n -1] > -1} {
	foreach {-- area num} [regexp -all -line -inline $rExp $data] {
	    set pnum "([string trim $area () ]) [string map {" " -} $num]"
	    if {!$n} { puts "[incr count]: $pnum" }
	}
    }
}

set N [lindex $argv 0]
if {$N < 1} {set N 1}
main $argv
