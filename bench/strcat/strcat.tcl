#!/usr/bin/tclsh
# $Id: strcat.tcl,v 1.1 2004-05-19 18:13:36 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/
# from: Kristoffer Lawson

proc main {n} {
    incr n
    while {[incr n -1]} {
        append str "hello\n"
    }
    puts [string length $str]
}

main [lindex $argv 0]
