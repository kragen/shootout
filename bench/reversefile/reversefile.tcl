#!/usr/bin/tclsh
# $Id: reversefile.tcl,v 1.1 2004-05-19 18:12:19 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/
# from: Miguel Sofer

proc main {} {
    set lines [split [read stdin] "\n"]
    
    fconfigure stdout -buffering full

    for {set i [expr {[llength $lines]-2}]} {$i >= 0} {incr i -1} {
        puts [lindex $lines $i]
    }
}

main
