"* The Computer Language Benchmarks Game
    http://shootout.alioth.debian.org/
    adapted from a program by Paolo Bonzini 
    contributed by Isaac Gouy *"!

Object subclass: #Thread   instanceVariableNames: 'name nextThread token semaphore'   classVariableNames: ''   poolDictionaries: ''   category: 'BenchmarksGame' !

!Thread methodsFor: 'accessing'!
name: anInteger   name := anInteger ! !

!Thread methodsFor: 'accessing'!
nextThread: aMessageThread   nextThread := aMessageThread ! !

!Thread methodsFor: 'accessing'!token   semaphore wait.   ^token ! !

!Thread methodsFor: 'accessing'!semaphore: aSemaphore   semaphore := aSemaphore ! !

!Thread methodsFor: 'accessing'!
fork   [ self run ] fork ! !

!Thread methodsFor: 'accessing'!
run   | x | 
   [ (x := self token) > 0 ] whileTrue: [ nextThread take: x - 1 ].
   Tests stdout print: name; nl ! !

!Thread methodsFor: 'accessing'!take: x   token := x.   semaphore signal ! !


!Thread class methodsFor: 'instance creation'!new
   ^self basicNew semaphore: Semaphore new ! !

!Thread class methodsFor: 'instance creation'!named: anInteger next: aThread   ^self new name: anInteger; nextThread: aThread; fork ! !


!Tests class methodsFor: 'benchmarking'!firstThread   | first last |
   503 to: 1 by: -1 do: [:i| 
      first := Thread named: i next: first.
      last isNil ifTrue: [ last := first ].
   ].
   last nextThread: first.   ^first ! !

!Tests class methodsFor: 'benchmarking'!threadring   self firstThread take: self arg.   ^''! !

Tests threadring!
