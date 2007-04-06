"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy *"!

Smalltalk.Shootout defineClass: #Tests
   superclass: #{Core.Object}
   indexedType: #none
   private: false
   instanceVariableNames: ''
   classInstanceVariableNames: ''
   imports: ''
   category: 'ComputerLanguageShootout' !

!Shootout.Tests class methodsFor: 'benchmark scripts'!

sumcol
   | stdin sum |
   stdin := ExternalReadStream on: 
      (ExternalConnection ioAccessor: (UnixDiskFileAccessor new handle: 0)).
   sum := 0.
   [stdin atEnd] whileFalse: [
      sum := sum + (stdin upTo: Character cr) asNumber].
   ^sum printString withNl ! !
