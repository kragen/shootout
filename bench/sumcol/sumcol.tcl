#!/usr/bin/tclsh
# $Id: sumcol.tcl,v 1.1 2004-05-19 18:13:44 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/
# from: Miguel Sofer

proc main {} {
    set sum 0
    while {[gets stdin line]> 0} {
	incr sum $line
    }
    puts $sum
}

main
