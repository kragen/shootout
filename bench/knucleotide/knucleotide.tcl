#!/usr/bin/tclsh

#  The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# contributed by Daniel South 


proc kFrequency {s k framesize} {
   global freq

   set n [string length $s]
   incr k -1
   incr n -$k
   for {set i [incr framesize -1]} {$i < $n} {incr i} {
      set c [string range $s $i [incr i $k]]
      if {[catch {incr freq($c)}]} {set freq($c) 1}
   }
}


proc frequency {s k} {
   array unset ::freq
   set sum 0

   for {set i 0} {$i < $k} {} {kFrequency $s $k [incr i]}
   foreach {fragment count} [array get ::freq] {
      lappend sortheap [list $fragment $count]
      incr sum $count
   }
   foreach item [lsort -integer -index 1 -decreasing [lsort $sortheap]] {
      set percent [expr {double([lindex $item 1]) / $sum * 100}]
      puts [format "%s %0.3f" [lindex $item 0] $percent]
   }
   puts ""
}

proc count {s fragment} {
    array unset ::freq
    set count 0

    set k [string length $fragment]
    for {set i 0} {$i < $k} {} {kFrequency $s $k [incr i]}
    if {[info exists ::freq($fragment)]} {set count $::freq($fragment)}
    puts $count\t$fragment
}

proc main {} {
    while {[gets stdin line] != -1} {if {[string match ">THREE*" $line]} break}
    while {[gets stdin line] != -1} {append sequence $line}
    set sequence [string toupper $sequence]

    frequency $sequence 1
    frequency $sequence 2

    count $sequence "GGT"
    count $sequence "GGTA"
    count $sequence "GGTATT"
    count $sequence "GGTATTTTAATT"
    count $sequence "GGTATTTTAATTTATAGT"
}

main
