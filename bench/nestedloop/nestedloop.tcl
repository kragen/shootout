#!/usr/bin/tclsh
# $Id: nestedloop.tcl,v 1.1 2004-05-19 18:10:57 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/
# from Tom Wilkason

proc main {} {
    global argv
    set n [lindex $argv 0]
    set x 0
    incr n 1
    set a $n
    while {[incr a -1]} {
	set b $n
	while {[incr b -1]} {
	    set c $n
	    while {[incr c -1]} {
		set d $n
		while {[incr d -1]} {
		    set e $n
		    while {[incr e -1]} {
			set f $n
			while {[incr f -1]} {
			    incr x
			}
		    }
		}
	    }
	}
    }
    puts $x
}

main
