#!/usr/bin/tclsh
# $Id: except.tcl,v 1.1 2004-05-19 18:09:43 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/
# with help from Kristoffer Lawson
# modified by Miguel Sofer

set HI 0
set LO 0

proc some_function {num} {
    if {[catch {hi_function $num} result]} {
        puts stderr "We shouldn't get here ($result)"
    }
}

proc hi_function {num} {
    if {[set exc [catch {lo_function $num}]] == 11} {
        # handle
	incr ::HI
    } else {
        # rethrow
	return -code $exc
    }
}

proc lo_function {num} {
    if {[set exc [catch {blowup $num}]] == 10} {
        # handle
	incr ::LO
    } else {
        # rethrow
	return -code $exc
    }
}

proc blowup {num} {
    if {$num % 2} {
        #error "Lo_exception"
	return -code 10
    } else {
        #error "Hi_exception"
	return -code 11
    }
}

proc main {} {
    global argv HI LO
    set NUM [lindex $argv 0]
    if {$NUM < 1} {
        set NUM 1
    }
    incr NUM
    while {[incr NUM -1]} {
        some_function $NUM
    }
    puts "Exceptions: HI=$HI / LO=$LO"
}

main
