#!/usr/bin/tclsh
##
## The Computer Lannguage Shootout
## http://shootout.alioth.debian.org/
## Contributed by Heiner Marxen
##
## "tcpsocket"	for Tcl
## Call:	stage /path/to/tcpsocket.tcl N
##
## $Id: tcpsocket.tcl,v 1.1 2005-12-15 03:27:42 igouy-guest Exp $

set PORT	11000
set BUFSIZ	1024
set REQSIZ	64

set repCSlist	[list 2 64  7 4096  1 409600]	;# pairs of Count and Size

proc fdConfig {fd} {
    fconfigure $fd -buffersize $::BUFSIZ -encoding binary -translation binary
}

proc doClient {n} {
    set fd {}
    for {set i 0} {$i < 3} {incr i} {
	if {![catch {set fd [socket localhost $::PORT]}]} break
	puts stderr ">>Client: retry..."
	after 100
    }
    fdConfig $fd

    set request [string repeat x $::REQSIZ]
    set replies 0
    set bytes   0.0		;# shall be summed as FP value

    foreach {cnt siz} $::repCSlist {
	set requests [expr {$n * $cnt}]
	for {set i 0} {$i < $requests} {incr i} {
	    puts -nonewline $fd $request ; flush $fd
	    set got [string length [read $fd $siz]]
	    incr replies
	    set  bytes   [expr {$bytes + $got}]
	}
    }

    puts "replies: $replies\tbytes: [format {%.0f} $bytes]"
}

proc Server {fd clientaddr clientport} {
    fdConfig $fd

    foreach {cnt siz} $::repCSlist {
	set requests [expr {$::N * $cnt}]
	set reply    [string repeat y $siz]

	for {set i 0} {$i < $requests} {incr i} {
	    set got [string length [read $fd $::REQSIZ]]
	    if {$got < $::REQSIZ} {
		puts stderr ">>Server: short request: $got < $::REQSIZ"
		break
	    }
	    puts -nonewline $fd $reply ; flush $fd
	}
    }

    set ::ready 1
}

proc doServer {n} {
    set ::N $n				;# tell "Server" via global var
    socket -server Server $::PORT
    vwait ::ready
}

proc main {argv} {
    set n 10
    if {[llength $argv]} {set n [lindex $argv 0]}

    if {$n > 0} {
	doClient $n
    } else {
	doServer [expr {abs($n)}]
    }
    return 0
}

main $argv
