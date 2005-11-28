"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Paolo Bonzini"!

!ComputerLanguageShootout.Benchmarks class methodsFor: 'benchmarking'!

message: argvString
   | n tail head sum |
   n := argvString asNumber.

   head := tail := Consumer new.
   500 timesRepeat: [
       head := ProducerConsumer fork: head ].

   sum := 0.
   n timesRepeat: [
       head msg: 0.
       sum := sum + tail msg ].

   OS.Stdout nextPutAll: sum printString; cr! !


Smalltalk.ComputerLanguageShootout defineClass: #Consumer
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'semaphore msg '
	classInstanceVariableNames: ''
	imports: ''
	category: 'ComputerLanguageShootout'!


!ComputerLanguageShootout.Consumer class methodsFor: 'process'!

new
    | var |
    var := self basicNew.
    var semaphore: Semaphore new.
    ^var! !


!ComputerLanguageShootout.Consumer methodsFor: 'process'!

msg
    semaphore wait.
    ^msg!

msg: data
    msg := data.
    semaphore signal!

semaphore: aSemaphore
    semaphore := aSemaphore! !


Smalltalk.ComputerLanguageShootout defineClass: #ProducerConsumer
	superclass: #{ComputerLanguageShootout.Consumer}
	indexedType: #none
	private: false
	instanceVariableNames: 'consumer '
	classInstanceVariableNames: ''
	imports: ''
	category: 'ComputerLanguageShootout'!


!ComputerLanguageShootout.ProducerConsumer class methodsFor: 'process'!

fork: consumer
    | proc |
    proc := self new.
    proc consumer: consumer.
    proc fork.
    ^proc! !

!ComputerLanguageShootout.ProducerConsumer methodsFor: 'process'!

consumer: aProcess
    consumer := aProcess!

fork
    [ self run ] fork!

run
    [ consumer msg: self msg + 1 ] repeat! !
