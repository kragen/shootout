"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy"!

!Shootout.Tests class methodsFor: 'benchmarking'!

takfp
   | n |
   n := CEnvironment argv first asNumber.
   ^(((n * 3.0) takfp: (n * 2.0) z: (n * 1.0)) asStringWith: 1) withNl ! !
