#!/usr/bin/tclsh
# $Id: echo.tcl,v 1.1 2004-05-19 18:09:38 bfulgham Exp $
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

    incr n
    while {[incr n -1]} {
	puts $sock $msg
	if {[string equal [gets $sock] $msg]} continue
	error "Received different message: $r."
    }
}


set n [lindex $argv 0]

if {[llength $argv] < 2} {
    socket -server newClient -myaddr localhost 10000
    #exec tclsh [info script] $n client &
    vwait forever
} else {
    runClient $n localhost 10000
}
