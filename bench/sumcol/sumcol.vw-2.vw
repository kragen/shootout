"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Eliot Miranda *"!


Smalltalk.Shootout defineClass: #Tests
   superclass: #{Core.Object}
   indexedType: #none
   private: false
   instanceVariableNames: ''
   classInstanceVariableNames: ''
   imports: ''
   category: 'ComputerLanguageShootout' !

!Shootout.Tests class methodsFor: 'benchmark scripts'!

sumcol2
   ^self sumStream: Stdin ! !

!Shootout.Tests class methodsFor: 'benchmarks'!

sumStream: input 
   | sum |
   sum := 0.
   [input atEnd] whileFalse:
      [sum := sum + (Integer readFrom: input radix: 10).
       input next].
   ^sum printString withNl ! !
