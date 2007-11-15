"* The Computer Language Benchmarks Game
    http://shootout.alioth.debian.org/
    adapted from a program by Paolo Bonzini 
    contributed by Isaac Gouy *"!

Object subclass: #Thread   instanceVariableNames: 'name nextThread token semaphore done'   classVariableNames: ''   poolDictionaries: ''   category: 'BenchmarksGame' !

!Thread methodsFor: 'accessing'!
name: anInteger   name := anInteger ! !

!Thread methodsFor: 'accessing'!
nextThread: aThread   nextThread := aThread ! !

!Thread methodsFor: 'accessing'!tokenNotDone   semaphore wait.   ^token > 0 ! !

!Thread methodsFor: 'accessing'!semaphore: aSemaphore   semaphore := aSemaphore ! !

!Thread methodsFor: 'accessing'!done: aSemaphore   done := aSemaphore ! !

!Thread methodsFor: 'accessing'!
fork   [ self run ] fork ! !

!Thread methodsFor: 'accessing'!
run 
   [ self tokenNotDone ] whileTrue: [ nextThread takeToken: token - 1 ].
   Tests stdout print: name; nl.
   done signal ! !

!Thread methodsFor: 'accessing'!takeToken: x   token := x.   semaphore signal ! !


!Thread class methodsFor: 'instance creation'!new
   ^self basicNew semaphore: Semaphore new ! !

!Thread class methodsFor: 'instance creation'!named: anInteger next: aThread done: aSemaphore   ^self new name: anInteger; nextThread: aThread; done: aSemaphore; fork ! !


!Tests class methodsFor: 'benchmarking'!threadRing: aSemaphore   | first last |
   503 to: 1 by: -1 do: [:i| 
      first := Thread named: i next: first done: aSemaphore.
      last isNil ifTrue: [ last := first ].
   ].
   last nextThread: first.   ^first ! !

!Tests class methodsFor: 'benchmarking'!threadring
   | done |   (self threadRing: (done := Semaphore new)) takeToken: self arg.
   done wait.   ^''! !



Tests threadring!
