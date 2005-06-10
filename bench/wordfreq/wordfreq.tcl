#!/usr/bin/tclsh
#
# $Id: wordfreq.tcl,v 1.4 2005-06-10 21:22:02 sgeard-guest Exp $
#
# http://shootout.alioth.debian.org/
# with help from: Tom Wilkason and Branko Vesligaj
#
# Speed increase by Roy Terry
proc main {} {

    set punc {\{\}"'\\!@#$%^&*()-_+=|[]:;,.~`?0123456789}
    foreach c [split $punc ""] {lappend map $c " "}
    while {[set data [read stdin 4096]] != {}} {
        if {[gets stdin extra] != -1} {append data $extra}
        set line [string map $map $data]
        foreach word [string tolower $line] {
            if {[catch {incr count($word)}]} {set count($word) 1}
        }
    }
    foreach {word cnt}  [array get count] {
        lappend lines [format "%7d %s" $cnt $word]
    }
    puts [join [lsort -decreasing $lines] "\n"]
}


main
