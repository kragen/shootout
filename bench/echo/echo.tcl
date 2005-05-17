#!/usr/bin/tclsh

# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# from: Kristoffer Lawson
# with help from Miguel Sofer
# modified by Daniel South

proc Server {channel clientaddr clientport} {
    fconfigure $channel -buffering line -encoding unicode
    set rLength 0
    while {![eof $channel]} {
	if {[gets $channel r] > 0} {
	    puts $channel $r
	    # Extra increase because [gets] doesn't return \n
	    incr rLength [string length $r]
	    incr rLength
	}
    }
    puts "server processed $rLength bytes"
    exit
}

proc doChild {num} {
    set fd [socket localhost 9900]
    fconfigure $fd -buffering line -encoding unicode
    set msg "Hello there sailor"

    while {[incr num -1] >= 0} {
	puts $fd $msg
	while {![gets $fd r]} {}
	if {$r ne $msg} {error "Received different message: $r."; exit}
    }
    close $fd
}

set n [lindex $argv 0]

if {[llength $argv] == 2} {
    doChild $n
} else {
    socket -server Server 9900
    exec [info nameofexecutable] [info script] $n & &
    vwait forever
}
