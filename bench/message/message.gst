"* The Computer Language Shootout
    http://shootout.alioth.debian.org/
    contributed by Paolo Bonzini *"!

Object subclass: #Consumer   instanceVariableNames: 'semaphore msg'   classVariableNames: ''   poolDictionaries: ''   category: 'Shootout'!

Consumer subclass: #ProducerConsumer   instanceVariableNames: 'consumer'   classVariableNames: ''   poolDictionaries: ''   category: 'Shootout'!

!Consumer methodsFor: 'accessing'!msg    semaphore wait.    ^msg! !!Consumer methodsFor: 'accessing'!msg: data    msg := data.    semaphore signal! !!Consumer methodsFor: 'accessing'!semaphore: aSemaphore    semaphore := aSemaphore! !!Consumer class methodsFor: 'instance creation'!new    | var |    var := self basicNew.    var semaphore: Semaphore new.    ^var! !!ProducerConsumer methodsFor: 'accessing'!consumer: aProcess    consumer := aProcess! !!ProducerConsumer methodsFor: 'accessing'!fork    [ self run ] fork! !!ProducerConsumer methodsFor: 'accessing'!run    [ consumer msg: self msg + 1 ] repeat! !!ProducerConsumer class methodsFor: 'instance creation'!fork: consumer    | proc |    proc := self new.    proc consumer: consumer.    proc fork.    ^proc! !!Tests class methodsFor: 'benchmarking'!message: n   | tail head sum |   head := tail := Consumer new.   500 timesRepeat: [head := ProducerConsumer fork: head].   sum := 0.   n timesRepeat:      [head msg: 0.      sum := sum + tail msg].   ^sum ! !!Tests class methodsFor: 'benchmark scripts'!message   self stdout print: (self message: self arg); nl.   ^''! !

Tests message!
