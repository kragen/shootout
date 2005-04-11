#!/usr/bin/tclsh

# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# contributed by Hemang Lavana


proc kFrequency {str offset framesize} {
   global freq

   set n [expr {[string length $str]-$offset}]
   for {set i $offset} {$i < $n} {incr i $framesize} {
      set fragment [string range $str $i [expr {$i+$framesize-1}]]
      if {[catch {incr freq($fragment)}]} {set freq($fragment) 1}
   }
}

proc frequency {str fsize} {
   array unset ::freq
   set sum 0

   for {set i 0} {$i < $fsize} {incr i} {kFrequency $str $i $fsize}
   foreach {fragment count} [array get ::freq] {
      lappend sortheap [list $fragment $count]
      incr sum $count
   }
   foreach item [lsort -integer -index 1 -decreasing $sortheap] {
      set percent [expr {double([lindex $item 1]) / $sum * 100}]
      puts [format "%s %0.3f" [lindex $item 0] $percent]
   }
   puts ""
}

proc count {str fragment} {
   array unset ::freq
   set count 0

   set fsize [string length $fragment]
   for {set i 0} {$i < $fsize} {incr i} {kFrequency $str $i $fsize}
   if {[info exists ::freq($fragment)]} {set count $::freq($fragment)}
   puts $count\t$fragment
}

proc main {} {
   while {[gets stdin line] != -1} {if {[string match ">THREE*" $line]} break}
   while {[gets stdin line] != -1} {
      set first_char [string index $line 0] 
      if {$first_char eq ">"} {
         break
      } elseif {$first_char ne ";"} {
         append sequence $line
      }
   }
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
