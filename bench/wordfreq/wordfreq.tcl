#!/usr/bin/tclsh
# $Id: wordfreq.tcl,v 1.2 2004-07-03 05:36:11 bfulgham Exp $
# http://shootout.alioth.debian.org/
# with help from: Tom Wilkason and Branko Vesligaj

proc main {} {
    while {1} {
	set data [read stdin 4096]
	if {[string equal $data {}]} {break}
	if {[gets stdin extra] >= 0} {
	    append data $extra
	}
	regsub -all  {[^[:alpha:]]+} $data { } line
	foreach word [string tolower $line] {
	    if {[catch {incr count($word)}]} {
		set count($word) 1
	    }
	}
    }
    foreach {word cnt}  [array get count] {
	lappend lines [format "%7d %s" $cnt $word]
    }
    puts [join [lsort -decreasing $lines] "\n"]
}

main

