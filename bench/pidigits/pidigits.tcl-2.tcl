## The Computer Lannguage Shootout
## http://shootout.alioth.debian.org/
## contributed by Hemang Lavana
## modified on advice from Mark Janssen

proc compose {aQRST bQRST} {
    foreach {aQ aR aS aT} $aQRST break
    foreach {bQ bR bS bT} $bQRST break
    set rQ [expr {$aQ * $bQ}]
    set rR [expr {$aQ * $bR + $aR * $bT}]
    set rS [expr {$aS * $bQ + $aT * $bS}]
    set rT [expr {$aS * $bR + $aT * $bT}]
    return [list $rQ $rR $rS $rT]
}

proc produce {QRST J} {
    return [compose [list 10 [expr {-10*$J}] 0 1] $QRST]
}

proc extract {QRST J} {
    foreach {Q R S T} $QRST break
    return [expr {($Q * $J + $R) / ($S * $J + $T)}]
}

proc nextX {} {
    global pidigit
    set k [incr pidigit(k)]
    return [list $k [expr {4*$k+2}] 0 [expr {2*$k+1}]]
}

proc nextPidigit {} {
    global pidigit
    set digit [extract $pidigit(z) 3]
    while {$digit != [extract $pidigit(z) 4]} {
        set pidigit(z) [compose $pidigit(z) [nextX]]
        set digit [extract $pidigit(z) 3]
    }
    set pidigit(z) [produce $pidigit(z) $digit]
    return $digit
}

proc newPidigit {} {
    global pidigit
    set pidigit(z) [list 1 0 0 1]
    set pidigit(k) 0
    return
}

proc generatePidigits {n} {
    set pi_digits [newPidigit]
    for {set i 0} {$i < $n} {incr i} {append pi_digits [nextPidigit]}
    return $pi_digits
}

proc main {n} {
    if {$n eq "" || $n < 27} {set n 27}
    set width 10
    set pi_digits [generatePidigits $n]

    set max [expr {$n-$width}]
    set len [expr {$width-1}]
    for {set i 0} {$i < $max} {} {
        puts "[string range $pi_digits $i [incr i $len]]\t:[incr i]"
    }
    if {$i < $n} {
        puts [format "%-${width}s\t:%s" [string range $pi_digits $i $n] $n]
    }
}
main [lindex $argv 0]
