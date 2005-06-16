#!/usr/bin/tclsh
# $Id: mandelbrot.tcl-3.tcl,v 1.1 2005-06-16 01:07:01 greg-guest Exp $
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Contributed by Hemang Lavana

proc main {argv} {
    set bit_num  [set byte_acc 0]
    set H [set W [lindex $argv 0]]

    puts stdout "P4\n$W $H"
    for {set y 0; set iter 50; set limit2 4.0; set W_1 [expr {$W-1}]; set Wshift [expr {8-$W%8}];} {$y < $H} {incr y} {
        set Ci [expr {2.0 * $y / $H - 1}]
        for {set x 0} {$x < $W} {incr x} {
            set Zr [set Zi 0.0]
            set Cr [expr {2.0 * $x / $W - 1.5}]
            for {set i 0} {$i < $iter} {incr i} {
                set Tr [expr { $Zr * $Zr - $Zi * $Zi + $Cr }]
                set Ti [expr { 2.0 * $Zr * $Zi + $Ci }]
                set Zr $Tr; set Zi $Ti
                if {[set isOverLimit [expr {($Zr * $Zr + $Zi * $Zi) > $limit2}]]} {break}
            }
            incr bit_num
            set byte_acc [expr {2 * $byte_acc + ($isOverLimit? 0 : 1)}]
            if {$bit_num == "8"} {
                puts -nonewline stdout [binary format c $byte_acc]
                set bit_num [set byte_acc 0]
            } elseif {$x == $W_1} {
                set byte_acc [expr { $byte_acc << $Wshift }]
                puts -nonewline stdout [binary format c $byte_acc]
                set bit_num [set byte_acc 0]
            }
        }
    }
}

main $argv
