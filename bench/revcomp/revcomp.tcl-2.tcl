# The Computer Language Benchmarks Game
# http://shootout.alioth.debian.org/
#
# contributed by Michael Schlenker
# optimized by Peter Niemayer
 
proc main {} {
  fconfigure stdout -buffering full -buffersize 16384 -translation binary
  set acc ""
  while {[gets stdin line] != -1} {
     if {[string index $line 0] == ">"} {
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

set map {A T a T C G c G G C g C T A t A U A u A M K m K R Y \
 r Y Y R y R K M k M V B v B H D h D D H d H B V b V}

proc put_reverse_fasta {head body} {
  global map
  set out [string reverse [string map $map $body]]
  set n [string length $out]
  puts $head
  for {set l -1} {[incr l] < $n} {} {
    puts [string range $out $l [incr l 59]]
  }
}

main
