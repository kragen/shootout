#!/usr/bin/tclsh
# $Id: tcpstream.tcl,v 1.2 2005-03-21 02:51:18 bfulgham Exp $
# http://shootout.alioth.debian.org/
#
# Contributed by Robert Seeger and Randy Melton
proc Server {channel clientaddr clientport} {
    set reply [string repeat x 409600]
    fconfigure $channel -buffersize 409600 -encoding binary

    while { [string length [read $channel 64]] == 64 } {
        puts -nonewline $channel $reply
    }

    set ::forever 1
}

proc doChild {num} {
    set request [string repeat x 64]

    set bytes 0
    set replies 0

    set fd [socket localhost 9900]
    fconfigure $fd -buffersize 64 -encoding binary

    while { [incr num -1] >= 0 } {
        puts -nonewline $fd $request
        incr bytes [string length [read $fd 409600]]
        incr replies
    }

    close $fd
    puts "replies: $replies\tbytes: $bytes"
    exit
}

if { [llength $argv] == 2} {
    doChild [lindex $argv 1]
} else {
    socket -server Server 9900

    exec [info script] Child [lindex $argv 0] &
    vwait ::forever

    exit
}

