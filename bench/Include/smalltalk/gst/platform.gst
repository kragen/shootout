


Object subclass: #Tests   instanceVariableNames: ''   classVariableNames: ''   poolDictionaries: ''   category: 'Shootout'!

!Tests class methodsFor: 'platform'!arg   ^Smalltalk arguments first asInteger! !!Tests class methodsFor: 'platform'!stdin   ^FileStream stdin! !

!Tests class methodsFor: 'platform'!stdinSpecial   ^self stdin bufferSize: 4096! ! !Tests class methodsFor: 'platform'!stdout   ^FileStream stdout! !

!Tests class methodsFor: 'platform'!stdoutSpecial
   ^self stdout bufferSize: 4096! ! 

!Stream methodsFor: 'platform'!print: number digits: decimalPlaces
   | n s |
   n := 0.5d0 * (10 raisedToInteger: decimalPlaces negated).
   s := ((number sign < 0) ifTrue: [number - n] ifFalse: [number + n]) printString.   self nextPutAll: (s copyFrom: 1 to: (s indexOf: $.) + decimalPlaces)! !

!Stream methodsFor: 'platform'!print: number paddedTo: width
   | s |
   s := number printString.   self nextPutAll: (String new: (width - s size) withAll: $ ), s! !!Integer methodsFor: 'platform'!asFloatD   ^self asFloat! !
