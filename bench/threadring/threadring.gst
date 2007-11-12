"* The Computer Language Benchmarks Game
    http://shootout.alioth.debian.org/
    adapted from a program by Paolo Bonzini 
    contributed by Isaac Gouy *"!

Object subclass: #TestThread   instanceVariableNames: 'name nextThread token semaphore'   classVariableNames: ''   poolDictionaries: ''   category: 'BenchmarksGame' !

!TestThread methodsFor: 'accessing'!
name: anInteger   name := anInteger ! !

!TestThread methodsFor: 'accessing'!
nextThread: aTestThread   nextThread := aTestThread ! !

!TestThread methodsFor: 'accessing'!token   semaphore wait.   ^token ! !

!TestThread methodsFor: 'accessing'!semaphore: aSemaphore   semaphore := aSemaphore ! !

!TestThread methodsFor: 'accessing'!
fork   [ self run ] fork ! !

!TestThread methodsFor: 'accessing'!
run   | x | 
   [ (x := self token) > 0 ] whileTrue: [ nextThread take: x - 1 ].
   Tests stdout print: name; nl ! !

!TestThread methodsFor: 'accessing'!take: x   token := x.   semaphore signal ! !


!TestThread class methodsFor: 'instance creation'!new
   ^self basicNew semaphore: Semaphore new ! !

!TestThread class methodsFor: 'instance creation'!named: anInteger next: aTestThread   ^self new name: anInteger; nextThread: aTestThread; fork ! !


!Tests class methodsFor: 'benchmarking'!firstThread   | first last |
   503 to: 1 by: -1 do: [:i| 
      first := TestThread named: i next: first.
      last isNil ifTrue: [ last := first ].
   ].
   last nextThread: first.   ^first ! !

!Tests class methodsFor: 'benchmarking'!threadring   self firstThread take: self arg.   ^''! !

Tests threadring!
