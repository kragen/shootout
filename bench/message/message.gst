"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/
 
   contributed by Paolo Bonzini
*"

Object subclass: #Consumer
	instanceVariableNames: 'semaphore msg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'shootout'!

!Consumer class methodsFor: 'process'!

new
    | var |
    var := self basicNew.
    var semaphore: Semaphore new.
    ^var! !
   
!Consumer methodsFor: 'process'!

semaphore: aSemaphore
    semaphore := aSemaphore!

msg
    semaphore wait.
    ^msg!

msg: data
    msg := data.
    semaphore signal! !

Consumer subclass: #ProducerConsumer
	instanceVariableNames: 'consumer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'shootout'!

!ProducerConsumer class methodsFor: 'process'!

fork: consumer
    | proc |
    proc := self new.
    proc consumer: consumer.
    proc fork.
    ^proc! !

!ProducerConsumer methodsFor: 'process'!

run
    [ consumer msg: self msg + 1 ] repeat!

fork
    [ self run ] fork!

consumer: aProcess
    consumer := aProcess! !


| arg tail head sum |
arg := Smalltalk arguments first asInteger.

head := tail := Consumer new.
500 timesRepeat: [
    head := ProducerConsumer fork: head ].

sum := 0.
arg timesRepeat: [
    head msg: 0.
    sum := sum + tail msg ].

sum printNl!
