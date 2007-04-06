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

revcomp2
   #('ONE' 'TWO' 'THREE') do:
      [:sequenceName | 
      self reverseComplementFrom: Stdin named: sequenceName to: Stdout].
   Stdout flush.
   ^'' ! !

!Shootout.Tests class methodsFor: 'auxillaries'!

reverseComplementFrom: input named: sequenceName to: output 
   | complement idString cr description char |
   complement := String new: 128.
   'ACGTUMRWSYKVHDBN'
      with: 'TGCAAKYWSRMBDHVN'
      do: [:a :b|
         complement at: a asInteger put: b.
         complement at: a asLowercase asInteger put: b asLowercase].

   idString := '>' , sequenceName.
   cr := Character cr.

   "find start of particular fasta sequence"
   [char := input peek.
    char == nil ifTrue: [^self].
   char = $> 
      ifTrue: 
         [((description := input upTo: cr) indexOfSubCollection: idString startingAt: 1) = 1]
      ifFalse: 
         [input skipThrough: cr.
         false]] 
      whileFalse.

   output nextPutAll: description; cr.
   [(char := input peek) = $> or: [char == nil]] whileFalse:
      [char = $; 
         ifTrue: [input skipUpTo: cr]
         ifFalse: 
            [[(char := input next) = cr] whileFalse:
               [output nextPut: (complement at: char asInteger)].
             output cr]] ! !
