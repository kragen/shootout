#!/usr/bin/tclsh
# $Id: sumcol.tcl,v 1.3 2005-09-29 17:36:19 igouy-guest Exp $
# http://www.bagley.org/~doug/shootout/
# from: Miguel Sofer 

proc main {} {
    set sum 0
    while {[gets stdin line]> 0} {incr sum $line}
    puts $sum
}

main
