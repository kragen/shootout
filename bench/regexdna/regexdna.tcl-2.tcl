# The Computer Language Shootout
# http://shootout.alioth.debian.org/
# contributed by Andrew McParland

set seq [read stdin]
set ilen [string length $seq]

regsub -all -line "(>.*)|(\n)" $seq "" seq
set clen [string length $seq]

set variants { {agggtaaa|tttaccct} 
               {[cgt]gggtaaa|tttaccc[acg]} 
               {a[act]ggtaaa|tttacc[agt]t} 
               {ag[act]gtaaa|tttac[agt]ct} 
               {agg[act]taaa|ttta[agt]cct} 
               {aggg[acg]aaa|ttt[cgt]ccct} 
               {agggt[cgt]aa|tt[acg]accct} 
               {agggta[cgt]a|t[acg]taccct} 
               {agggtaa[cgt]|[acg]ttaccct} }

foreach f $variants {
    puts "$f [regexp -all $f $seq]"
}

set subs { B  (c|g|t)  D  (a|g|t)    H  (a|c|t)  K  (g|t) 
           M  (a|c)    N  (a|c|g|t)  R  (a|g)    S  (c|g) 
           V  (a|c|g)  W  (a|t)      Y  (c|t) }

set seq [string map $subs $seq]

puts ""
puts $ilen
puts $clen
puts [string length $seq]
