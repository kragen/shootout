#!/usr/bin/tclsh
# $Id: sumcol.tcl,v 1.2 2005-03-31 15:43:13 sgeard-guest Exp $
# http://www.bagley.org/~doug/shootout/
# from: Miguel Sofer

proc main {} {
    set sum 0
    while {[gets stdin line]> 0} {incr sum $line}
    puts $sum
}

main
