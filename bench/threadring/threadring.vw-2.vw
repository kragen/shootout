"* The Computer Language Benchmarks Game
    http://shootout.alioth.debian.org/
    adapted from a program by Paolo Bonzini
    contributed by Isaac Gouy 
    modified by Carlo Teixeira *"!

!Tests class methodsFor: 'benchmarking'!

threadring2
   | done |
   (self threadRing: (done := Semaphore new)) takeToken: self arg.
   done wait.
   ^''!

threadRing: aSemaphore
   | first last |
   503 to: 1 by: -1 do: [:i|
      first := Thread named: i next: first done: aSemaphore.
      last isNil ifTrue: [ last:=first. ].
   ].
   last nextThread: first.
   ^first! !


Object subclass: #Thread
   instanceVariableNames: 'name nextThread token semaphore done '
   classVariableNames: ''
   poolDictionaries: ''
   category: 'BenchmarksGame'!

Thread class
   instanceVariableNames: ''!


!Thread class methodsFor: 'instance creation'!

named: anInteger next: aThread done: aSemaphore
   ^self new name: anInteger; nextThread: aThread; done: aSemaphore; fork !

new
   ^self basicNew semaphore: Semaphore new ! !


!Thread methodsFor: 'accessing'!

done: aSemaphore
   done := aSemaphore !

fork
   [ self run ] forkAt: Processor userBackgroundPriority.!

name: anInteger
   name := anInteger !

nextThread: aThread
   nextThread := aThread !

run
   [semaphore wait.
   0==token] whileFalse: [nextThread takeToken: token - 1].
   name printOn: Tests stdout.
   Tests stdout cr.
   done signal!

semaphore: aSemaphore
   semaphore := aSemaphore !

takeToken: x
   token := x.
   semaphore signal ! !
