#!/usr/bin/tclsh
# $Id: regexmatch.tcl,v 1.1 2004-05-19 18:11:28 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/
# from: Miguel Sofer, with modifications by Kristoffer Lawson

proc main {} {
    global argv
    set NUM [lindex $argv 0]
    if {$NUM < 1} {
        set NUM 1
    }

    set data [read stdin]
    set count 0    
    set rExp {(?:^|[^\d(])(\(\d{3}\)|\d{3}) (\d{3}[ -]\d{4})(?:$|[^\d])}

    while {$NUM} {
	incr NUM -1
	foreach {-- area num} [regexp -all -line -inline $rExp $data] {
	    set pnum "([string trim $area () ]) [string map {" " -} $num]"
	    if {!$NUM} {
		puts "[incr count]: $pnum"
	    }
	}
    }
}

main
