#!/usr/bin/tclsh
# $Id: echo.tcl,v 1.2 2004-07-01 05:23:59 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

# from: Kristoffer Lawson
# with help from Miguel Sofer

proc newClient {sock addr port} {
    fconfigure $sock -buffering line -encoding unicode
    set r [gets $sock]
    set rLength 0
    while {![eof $sock]} {
	# Extra increase because [gets] doesn't return \n
	incr rLength [expr {[string length $r] + 1}]
	puts $sock $r
	set r [gets $sock]
    }
    puts "server processed $rLength bytes"
    exit
}


proc runClient {n addr port} {
    set sock [socket $addr $port]
    fconfigure $sock -buffering line -encoding unicode
    set msg "Hello there sailor"

    while {$n} {
        puts $sock $msg
	if {[gets $sock] != $msg} {
	    error "Received different message: $r."
	}
	incr n -1
    }
}

set n [lindex $argv 0]

if {[llength $argv] < 2} {
    socket -server newClient 10000 -myaddr localhost 10000
    exec [info nameofexecutable] [info script] $n client &
    vwait forever
} else {
    runClient $n localhost 10000
}
