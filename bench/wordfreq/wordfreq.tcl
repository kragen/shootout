#!/usr/bin/tclsh
# $Id: wordfreq.tcl,v 1.1 2004-05-19 18:14:18 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/
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
	lappend lines [format "%7d\t%s" $cnt $word]
    }
    puts [join [lsort -decreasing $lines] "\n"]
}

main

