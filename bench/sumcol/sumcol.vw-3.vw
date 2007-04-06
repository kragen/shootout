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

sumcol3
   ^self sumStream3: Stdin ! !

!Shootout.Tests class methodsFor: 'benchmarks'!

sumStream3: input 
   | sum |
   sum := 0.
   [input atEnd] whileFalse:
      [sum := sum + (stdin upTo: Character cr) asNumber].
   ^sum printString withNl ! !
