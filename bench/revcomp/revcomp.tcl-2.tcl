# The Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# contributed by Stephane Arnold

proc main {} {
    set acc ""
    while {[gets stdin line] != -1} {
	if {[string equal [string index $line 0] >]} {
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
    set body [string toupper $body]
    set body [string map {A T C G G C T A U A M K R Y Y R K M V B H D D H B V} $body]
    set l [string length $body]
    for {set i 0} {$i<$l} {incr i} {
        if {!($i % 60)} {append head \n}
        append head [string index $body end-$i]
    }
    puts $head
}
main