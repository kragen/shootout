#!/usr/bin/tclsh
# $Id: revcomp.tcl,v 1.3 2005-09-29 17:36:19 igouy-guest Exp $
# http://shootout.alioth.debian.org/
#
# reverse-complement benchmark for shootout.alioth.debian.org 
#
# contributed by Michael Schlenker <mic42@users.sourceforge.net>
#
proc main {} {
    set acc ""
    while {[gets stdin line] != -1} {
	if {[string match ">*" $line]} {
	    if {[string length $acc]} {
		put_reverse_fasta $head $acc
		set acc ""
	    }
	    set head $line
	} else {
	    append acc $line
	}
    }
    put_reverse_fasta $head $acc
}

proc put_reverse_fasta {head body} {
    set l [string length $body]
    set body [string map {A T a T C G c G G C g C T A t A U A u A M K m K R Y \
	    r Y Y R y R K M k M V B v B H D h D D H d H B V b V} $body]
    while {$l} {append out [string index $body [incr l -1]]}
    incr l -1
    set body $head
    while {[incr l] < [string length $out]} {
	append body \n[string range $out $l [incr l 59]]
    }
    puts $body
}

main
