"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy *"

| sum | sum := 0.
(FileStream stdin bufferSize: 4096) linesDo: [:each| sum := sum + each asInteger].
sum displayNl !

