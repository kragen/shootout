#!/usr/bin/tclsh
# $Id: wordfreq.tcl,v 1.3 2005-03-31 15:47:06 sgeard-guest Exp $
# http://shootout.alioth.debian.org/
# with help from: Tom Wilkason and Branko Vesligaj

proc main {} {
    while {[set data [read stdin 4096]] != {}} {
	if {[gets stdin extra] != -1} {append data $extra}
	regsub -all {[^[:alpha:]]+} $data { } line
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
