# The Computer Language Benchmarks Game
# http://shootout.alioth.debian.org/
# contributed by Stephane Arnold

proc main {W} {
    set H $W

    puts stdout "P4\n$W $H"
	fconfigure stdout -translation binary
	set iter 50
	set limit2 4.0
	set wscale [expr {2./$W}]
	set hscale [expr {2./$H}]
	set offset [expr {$W%8}]
    for {set y 0} {$y < $H} {incr y} {
        set Ci [expr {$hscale* double($y) -1.0}]
        for {set xb 0} {$xb < $W} {incr xb 8} {
			set bits 0
			set xbb [expr {$xb+8 > $W ? $W : $xb+8}]
			for {set x $xb} {$x<$xbb} {incr x} {
			  set bits [expr {$bits<<1}]
			   set Zr [set Zi 0.0]
            set Zrq [set Ziq 0.0]
            set Cr [expr {$wscale * double($x)- 1.5}]
            for {set i 0} {$i<$iter} {incr i} {
               set Zri [expr {$Zr*$Zi}]
               set Zr [expr { $Zrq - $Ziq + $Cr }]
               set Zi [expr { $Zri + $Zri + $Ci }]
               set Zrq [expr {$Zr*$Zr}]
               set Ziq [expr {$Zi*$Zi}]
               if {$Zrq + $Ziq > $limit2} {
                  incr bits
                  break
               }
            }
         }
         if {$xb+7>=$W} {set bits [expr {(($bits+1)<<$offset)-1}]}
         puts -nonewline stdout [binary format c [expr {255-$bits}]]
        }
    }
}
eval main $argv
