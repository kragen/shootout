"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy"!

!Shootout.Tests class methodsFor: 'benchmarking'!

sumcol
   | stdin sum |
   stdin := ExternalReadStream on: 
      (ExternalConnection ioAccessor: (UnixDiskFileAccessor new handle: 0)).
   sum := 0.
   [stdin atEnd] whileFalse: [
      sum := sum + (stdin upTo: Character cr) asNumber].
   ^sum printString withNl ! !
