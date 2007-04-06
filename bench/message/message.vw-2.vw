"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Paolo Bonzini *"!


Smalltalk.Shootout defineClass: #Tests
   superclass: #{Core.Object}
   indexedType: #none
   private: false
   instanceVariableNames: ''
   classInstanceVariableNames: ''
   imports: ''
   category: 'ComputerLanguageShootout' !

!Shootout.Tests class methodsFor: 'benchmark scripts'!

message2
   ^(self message: CEnvironment argv first asNumber) printString withNl ! !


!Shootout.Tests class methodsFor: 'benchmarks'!

message: n
   | tail head sum |
   head := tail := Consumer new.
   500 timesRepeat: [head := ProducerConsumer fork: head].
   sum := 0.
   n timesRepeat:
      [head msg: 0.
      sum := sum + tail msg].
   ^sum ! !


Smalltalk.Shootout defineClass: #Consumer
   superclass: #{Core.Object}
   indexedType: #none
   private: false
   instanceVariableNames: 'semaphore msg '
   classInstanceVariableNames: ''
   imports: ''
   category: 'Shootout'!


!Shootout.Consumer class methodsFor: 'process'!

new
    | var |
    var := self basicNew.
    var semaphore: Semaphore new.
    ^var! !


!Shootout.Consumer methodsFor: 'process'!

msg
    semaphore wait.
    ^msg!

msg: data
    msg := data.
    semaphore signal!

semaphore: aSemaphore
    semaphore := aSemaphore! !


Smalltalk.Shootout defineClass: #ProducerConsumer
   superclass: #{Shootout.Consumer}
   indexedType: #none
   private: false
   instanceVariableNames: 'consumer '
   classInstanceVariableNames: ''
   imports: ''
   category: 'Shootout'!


!Shootout.ProducerConsumer class methodsFor: 'process'!

fork: consumer
    | proc |
    proc := self new.
    proc consumer: consumer.
    proc fork.
    ^proc! !

!Shootout.ProducerConsumer methodsFor: 'process'!

consumer: aProcess
    consumer := aProcess!

fork
    [ self run ] fork!

run
    [ consumer msg: self msg + 1 ] repeat! !
