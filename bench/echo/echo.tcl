#!/usr/bin/tclsh

# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# from: Kristoffer Lawson
# with help from Miguel Sofer
# modified by Daniel South

proc newClient {sock addr port} {
   fconfigure $sock -buffering line -encoding unicode
   set r [gets $sock]
   set rLength 0
   while {![eof $sock]} {
      # Extra increase because [gets] doesn't return \n
      incr rLength [string length $r]
      incr rLength
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
      if {[gets $sock] != $msg} {error "Received different message: $r."}
   }
}

set n [lindex $argv 0]

if {[llength $argv] < 2} {
   socket -server newClient -myaddr localhost 10000
   exec [info nameofexecutable] [info script] $n client &
   vwait forever
} else {
   runClient $n localhost 10000
}
